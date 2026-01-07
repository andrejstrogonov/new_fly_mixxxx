import 'package:equatable/equatable.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/audio_repository.dart';
import 'base_usecase.dart';

class SeekAudioParams extends UseCaseParams {
  final Duration position;
  final int playerNumber; // 1 или 2

  const SeekAudioParams({
    required this.position,
    required this.playerNumber,
  });

  @override
  List<Object?> get props => [position, playerNumber];
}

/// UseCase для перемотки трека
class SeekAudioUseCase extends UseCase<void, SeekAudioParams> {
  final AudioRepository audioRepository;

  SeekAudioUseCase({required this.audioRepository});

  @override
  Future<Result<void>> call(SeekAudioParams params) async {
    // Валидация
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(
        message: 'Invalid player number',
        code: 'INVALID_PLAYER',
      );
    }

    if (params.position.isNegative) {
      return Failure(
        message: 'Position cannot be negative',
        code: 'INVALID_POSITION',
      );
    }

    return await audioRepository.seek(
      params.position,
      playerNumber: params.playerNumber,
    );
  }
}

