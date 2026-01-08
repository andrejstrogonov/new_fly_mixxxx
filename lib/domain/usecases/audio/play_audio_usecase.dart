import 'package:equatable/equatable.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';
import 'package:new_fly_mixxxx/domain/repositories/audio_repository.dart';
import 'package:new_fly_mixxxx/domain/usecases/base_usecase.dart';

class PlayAudioParams extends UseCaseParams {
  final int playerNumber; // 1 или 2

  const PlayAudioParams({required this.playerNumber});

  @override
  List<Object?> get props => [playerNumber];
}

/// UseCase для начала воспроизведения
class PlayAudioUseCase extends UseCase<void, PlayAudioParams> {
  final AudioRepository audioRepository;

  PlayAudioUseCase({required this.audioRepository});

  @override
  Future<Result<void>> call(PlayAudioParams params) async {
    // Валидация
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(
        message: 'Invalid player number',
        code: 'INVALID_PLAYER',
      );
    }

    return await audioRepository.play(playerNumber: params.playerNumber);
  }
}
