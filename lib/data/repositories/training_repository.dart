import '../models/training_model.dart';
import 'training_details_response.dart';

class TrainingRepository {
  Future<TrainingModel> getTrainingsData() async {
    final Map<String, dynamic> resp = responseJson;
    return TrainingModel.fromJson(resp);
  }
}
