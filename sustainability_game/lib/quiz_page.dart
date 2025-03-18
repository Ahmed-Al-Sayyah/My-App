import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'translations/app_translations.dart';
import 'questions.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final String level;

  const QuizPage({Key? key, required this.level}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showExplanation = false;
  bool _isQuizComplete = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(bool isCorrect) async {
    try {
      if (isCorrect) {
        await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
      } else {
        await _audioPlayer.play(AssetSource('sounds/incorrect.mp3'));
      }
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _checkAnswer(int selectedAnswer) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final currentQuestions = questions[languageProvider.currentLocale.languageCode]?[widget.level] ?? [];
    final currentQuestion = currentQuestions[_currentQuestionIndex];

    if (selectedAnswer == currentQuestion.correctAnswerIndex) {
      setState(() {
        _score++;
        _showExplanation = true;
      });
      _playSound(true);
    } else {
      setState(() {
        _showExplanation = true;
      });
      _playSound(false);
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (_currentQuestionIndex < currentQuestions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _showExplanation = false;
          });
        } else {
          setState(() {
            _isQuizComplete = true;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                score: _score,
                totalQuestions: currentQuestions.length,
                level: widget.level,
              ),
            ),
          );
        }
      }
    });
  }

  void _showResults() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentQuestions = questions[languageProvider.currentLocale.languageCode]?[widget.level] ?? [];
    final isDarkMode = themeProvider.isDarkMode;

    _confettiController.play();
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                AppTranslations.translate('quizComplete', languageProvider.currentLocale.languageCode),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode 
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  '${AppTranslations.translate('finalScore', languageProvider.currentLocale.languageCode)}: $_score/${currentQuestions.length}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                    shadows: isDarkMode
                        ? [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  color: _score >= currentQuestions.length * 0.7
                      ? Colors.green.withOpacity(isDarkMode ? 0.2 : 0.1)
                      : _score >= currentQuestions.length * 0.5
                          ? Colors.orange.withOpacity(isDarkMode ? 0.2 : 0.1)
                          : Colors.red.withOpacity(isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: _score >= currentQuestions.length * 0.7
                        ? Colors.green.withOpacity(0.3)
                        : _score >= currentQuestions.length * 0.5
                            ? Colors.orange.withOpacity(0.3)
                            : Colors.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  _score >= currentQuestions.length * 0.7
                      ? AppTranslations.translate('excellent', languageProvider.currentLocale.languageCode)
                      : _score >= currentQuestions.length * 0.5
                          ? AppTranslations.translate('good', languageProvider.currentLocale.languageCode)
                          : AppTranslations.translate('tryAgain', languageProvider.currentLocale.languageCode),
                  style: TextStyle(
                    fontSize: 22,
                    color: _score >= currentQuestions.length * 0.7
                        ? Colors.green
                        : _score >= currentQuestions.length * 0.5
                            ? Colors.orange
                            : Colors.red,
                    fontWeight: FontWeight.bold,
                    shadows: isDarkMode
                        ? [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode 
                        ? Theme.of(context).primaryColor.withOpacity(0.8)
                        : Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: isDarkMode ? 8 : 4,
                    shadowColor: isDarkMode
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                  child: Text(
                    AppTranslations.translate('backToHome', languageProvider.currentLocale.languageCode),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: isDarkMode
                          ? [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentQuestions = questions[languageProvider.currentLocale.languageCode]?[widget.level] ?? [];
    final currentQuestion = currentQuestions[_currentQuestionIndex];
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppTranslations.translate('quiz', languageProvider.currentLocale.languageCode),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.language,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onSelected: (String value) {
              if (value == 'ar') {
                languageProvider.setLocale(const Locale('ar'));
              } else if (value == 'en') {
                languageProvider.setLocale(const Locale('en'));
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'ar',
                child: Text(
                  'العربية',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'en',
                child: Text(
                  'English',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDarkMode 
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Theme.of(context).primaryColor.withOpacity(0.1),
                  isDarkMode
                    ? Colors.grey[900]!
                    : Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[850] : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode 
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: isDarkMode 
                          ? Theme.of(context).primaryColor.withOpacity(0.3)
                          : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: (_currentQuestionIndex + 1) / currentQuestions.length,
                          backgroundColor: isDarkMode 
                            ? Colors.grey[800]
                            : Theme.of(context).primaryColor.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDarkMode 
                              ? Theme.of(context).primaryColor.withOpacity(0.8)
                              : Theme.of(context).primaryColor
                          ),
                          minHeight: 8,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${AppTranslations.translate('question', languageProvider.currentLocale.languageCode)} ${_currentQuestionIndex + 1}/${currentQuestions.length}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[850] : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode 
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: isDarkMode 
                          ? Theme.of(context).primaryColor.withOpacity(0.3)
                          : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      currentQuestion.questionText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...currentQuestion.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected = _showExplanation && index == currentQuestion.correctAnswerIndex;
                    final isWrong = _showExplanation && index != currentQuestion.correctAnswerIndex;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: _showExplanation ? null : () => _checkAnswer(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? Colors.green.withOpacity(0.9)
                              : isWrong
                                  ? Colors.red.withOpacity(0.9)
                                  : isDarkMode
                                      ? Theme.of(context).primaryColor.withOpacity(0.8)
                                      : Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: isDarkMode ? 8 : 4,
                          shadowColor: isDarkMode
                              ? Theme.of(context).primaryColor.withOpacity(0.5)
                              : Theme.of(context).primaryColor.withOpacity(0.3),
                          overlayColor: isDarkMode
                              ? Colors.white.withOpacity(0.1)
                              : Colors.white.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  shadows: isDarkMode
                                      ? [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.3),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                            ),
                            if (_showExplanation) ...[
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : isWrong
                                          ? Colors.white.withOpacity(0.2)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isSelected
                                      ? Icons.check_circle
                                      : isWrong
                                          ? Icons.cancel
                                          : null,
                                  color: isSelected
                                      ? Colors.white
                                      : isWrong
                                          ? Colors.white
                                          : null,
                                  size: 24,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  if (_showExplanation) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[850] : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode 
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: isDarkMode 
                              ? Theme.of(context).primaryColor.withOpacity(0.3)
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTranslations.translate('explanation', languageProvider.currentLocale.languageCode),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode 
                                  ? Theme.of(context).primaryColor.withOpacity(0.8)
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentQuestion.explanation,
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: math.pi / 2,
            maxBlastForce: 5,
            minBlastForce: 1,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ],
      ),
    );
  }
} 