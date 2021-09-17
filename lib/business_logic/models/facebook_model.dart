import 'dart:convert';

Facebook facebookFromJson(String str) => Facebook.fromJson(json.decode(str));

String facebookToJson(Facebook data) => json.encode(data.toJson());

class Facebook {
    Facebook({
        this.id,
        this.firstName,
        this.lastName,
        this.name,
        this.picture,
        this.email,
    });

    String id;
    String firstName;
    String lastName;
    String name;
    Picture picture;
    String email;

    factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        name: json["name"],
        picture: Picture.fromJson(json["picture"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "name": name,
        "picture": picture.toJson(),
        "email": email,
    };
}

class Picture {
    Picture({
        this.data,
    });

    Data data;

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.height,
        this.isSilhouette,
        this.url,
        this.width,
    });

    int height;
    bool isSilhouette;
    String url;
    int width;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        height: json["height"],
        isSilhouette: json["is_silhouette"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "is_silhouette": isSilhouette,
        "url": url,
        "width": width,
    };
}