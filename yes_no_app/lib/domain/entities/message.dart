enum FromWho { me, hers }

class Message {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  Message({ required this.text, required this.fromWho, this.imageUrl});
}
