import 'package:tiktok/domain/entities/video_post.dart';

abstract class VideoPostRepository {

  Future<List<VideoPost>> getFavoriteVideosByPage(String userID);

  Future<List<VideoPost>> getTrendingVideosByPage(int page);

}
