import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_option.dart';

class QuizData {
  static final List<QuizModel> quiz =  [
  QuizModel(
    title: 'In a healthcare app development project, why would a team use Git?',
    quizOptions: [
      const QuizOption(option: 'To manage different versions of medical data.', id: 1),
      const QuizOption(option: 'To track and collaborate on code changes.', id: 2),
      const QuizOption(option: 'To store patient medical records securely.', id: 3),
      const QuizOption(option: 'To manage patient appointment schedules.', id: 4),
    ],
    correctAnswer: 'To track and collaborate on code changes.',
    id: 1,
  ),
  QuizModel(
    title: 'Which Git command is used to create a new branch for a healthcare feature?',
    quizOptions: [
      const QuizOption(option: 'git create', id: 1),
      const QuizOption(option: 'git branch', id: 2),
      const QuizOption(option: 'git clone', id: 3),
      const QuizOption(option: 'git merge', id: 4),
    ],
    correctAnswer: 'git branch',
    id: 2,
  ),
  QuizModel(
    title: 'Why would healthcare developers use "git pull" in a collaborative environment?',
    quizOptions: [
      const QuizOption(option: 'To fetch and integrate updates from the remote repository.', id: 1),
      const QuizOption(option: 'To push local changes to the server.', id: 2),
      const QuizOption(option: 'To create a new branch for patient data updates.', id: 3),
      const QuizOption(option: 'To check the status of medical records integration.', id: 4),
    ],
    correctAnswer: 'To fetch and integrate updates from the remote repository.',
    id: 3,
  ),
  QuizModel(
    title: 'How can Git help in maintaining compliance in healthcare software development?',
    quizOptions: [
      const QuizOption(option: 'By ensuring version control for patient data files.', id: 1),
      const QuizOption(option: 'By enabling encryption of sensitive patient information.', id: 2),
      const QuizOption(option: 'By tracking changes and making auditing easier.', id: 3),
      const QuizOption(option: 'By testing new features in a branch without affecting patient care.', id: 4),
    ],
    correctAnswer: 'By tracking changes and making auditing easier.',
    id: 4,
  ),
  QuizModel(
    title: 'In the development of a telemedicine app, how would Git be used for collaboration?',
    imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
    quizOptions: [
      const QuizOption(option: 'It allows developers to create features for remote patient consultations.', id: 1),
      const QuizOption(option: 'It helps in storing medical records for patient history.', id: 2),
      const QuizOption(option: 'It facilitates version control and code review for team collaboration.', id: 3),
      const QuizOption(option: 'It assists in tracking patient appointments and diagnoses.', id: 4),
    ],
    correctAnswer: 'It facilitates version control and code review for team collaboration.',
    id: 5,
  ),
  QuizModel(
    title: 'What is the role of Git in managing a multi-developer team working on a healthcare mobile app?',
    quizOptions: [
      const QuizOption(option: 'Git allows each developer to manage personal patient records locally.', id: 1),
      const QuizOption(option: 'Git enables version control and prevents conflicts in code changes.', id: 2),
      const QuizOption(option: 'Git helps to ensure secure access to medical data remotely.', id: 3),
      const QuizOption(option: 'Git manages the workflow of data syncing between clinics and hospitals.', id: 4),
    ],
    correctAnswer: 'Git enables version control and prevents conflicts in code changes.',
    id: 6,
  ),
];
}