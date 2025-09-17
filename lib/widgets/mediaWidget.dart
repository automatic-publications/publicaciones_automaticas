import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MediaViewer extends StatefulWidget {
  final String? imageUrl;
  final String? videoUrl;

  const MediaViewer({super.key, this.imageUrl, this.videoUrl});

  @override
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.videoUrl != null && widget.videoUrl != "0") {
      _controller = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
          _controller!.setLooping(true);
          _controller!.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoUrl != null && widget.videoUrl != "0") {
      if (_controller != null && _controller!.value.isInitialized) {
        return AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }

    if (widget.imageUrl != null && widget.imageUrl != "0") {
      return Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, color: Colors.red),
      );
    }

    return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
  }
}
