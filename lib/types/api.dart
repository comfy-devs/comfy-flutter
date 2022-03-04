/* Base Types */
class APIGetRequest {
	final String path;

	APIGetRequest(this.path);
}

class APIPostRequest {
	final String path;
	final Object body;

	APIPostRequest(this.path, this.body);
}

class APIResponse {
	final int status;
	final Object body;

	APIResponse(this.status, this.body);
}

/* Types */
class Preferences {
	bool skipToPlayer = false;
}

class Anime {
	final String id;
	final String? group;
	final int? season;
	final String title;
	final String? synopsis;
	final int episodes;
	final int favourites;
	final int type;
	final int status;
	final int genres;
	final int tags;
	final int rating;
	final int presets;
	final int location;
	final int? timestamp;

  	Anime(this.id, this.group, this.season, this.title, this.synopsis, this.episodes, this.favourites, this.type, this.status, this.genres, this.tags, this.rating, this.presets, this.location, this.timestamp);

  	Anime.fromJson(Map<String, dynamic> json)
      : id = json['id'],
	  group = json['group'],
	  season = json['season'],
	  title = json['title'],
	  synopsis = json['synopsis'],
	  episodes = json['episodes'],
	  favourites = json['favourites'],
	  type = json['type'],
	  status = json['status'],
	  genres = json['genres'],
	  tags = json['tags'],
	  rating = json['rating'],
	  presets = json['presets'],
	  location = json['location'],
	  timestamp = json['timestamp'];
}

class Episode {
	final String id;
	final int pos;
	final String anime;
	final String title;
	final int views;

  	Episode(this.id, this.pos, this.anime, this.title, this.views);

  	Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
	  pos = json['pos'],
	  anime = json['anime'],
	  title = json['title'],
	  views = json['views'];
}

class Segment {
	final String id;
	final int pos;
	final String episode;
	final int type;
	final int length;

  	Segment(this.id, this.pos, this.episode, this.type, this.length);

  	Segment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
	  pos = json['pos'],
	  episode = json['episode'],
	  type = json['type'],
	  length = json['length'];
}