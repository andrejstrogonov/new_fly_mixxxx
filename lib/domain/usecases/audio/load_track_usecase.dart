import 'package:equatable/equatable.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/entities/track_entity.dart';
import 'base_usecase.dart';

class LoadTrackParams extends UseCaseParams {
  final TrackEntity track;
  final int playerNumber; // 1 или 2

  const LoadTrackParams({
    required this.track,
    required this.playerNumber,
  });

  @override
  List<Object?> get props => [track, playerNumber];
}

/// UseCase для загрузки трека в плеер
class LoadTrackUseCase extends UseCase<void, LoadTrackParams> {
  final AudioRepository audioRepository;

  LoadTrackUseCase({required this.audioRepository});

  @override
  Future<Result<void>> call(LoadTrackParams params) async {
    // Валидация
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(
        message: 'Invalid player number',
        code: 'INVALID_PLAYER',
      );
    }

    // Выполнение бизнес-логики
    return await audioRepository.loadTrack(
      params.track,
      playerNumber: params.playerNumber,
    );
  }
}

