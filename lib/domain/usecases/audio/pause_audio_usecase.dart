import 'package:equatable/equatable.dart';
import 'package:new_fly_mixxxx/domain/entities/result.dart';
import 'package:new_fly_mixxxx/domain/repositories/audio_repository.dart';
import 'package:new_fly_mixxxx/domain/usecases/base_usecase.dart';

class PauseAudioParams extends UseCaseParams {
  final int playerNumber; // 1 или 2

  const PauseAudioParams({required this.playerNumber});

  @override
  List<Object?> get props => [playerNumber];
}

/// UseCase для паузы воспроизведения
class PauseAudioUseCase extends UseCase<void, PauseAudioParams> {
  final AudioRepository audioRepository;

  PauseAudioUseCase({required this.audioRepository});

  @override
  Future<Result<void>> call(PauseAudioParams params) async {
    if (params.playerNumber < 1 || params.playerNumber > 2) {
      return Failure(
        message: 'Invalid player number',
        code: 'INVALID_PLAYER',
      );
    }

    return await audioRepository.pause(playerNumber: params.playerNumber);
  }
}
