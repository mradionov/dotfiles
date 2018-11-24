ffbs() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ffbs INPUT OUTPUT"
    echo "Extracts H264 bitstream from a video file."
    echo "Example: ffbs input.mp4 output.h264"
    return 1
  fi

  ffmpeg -i $1 -c:v copy -an -bsf:v h264_mp4toannexb $2
}

ffcb() {
  if [ -z "$1" ]; then
    echo "Usage: ffcb INPUT"
    echo "Outputs video file B-frames count."
    echo "Example: ffcb input.mp4"
    return 1
  fi

  ffprobe $1 -select_streams v:0 -show_frames -v quiet | grep pict_type=B -c
}

ffci() {
  if [ -z "$1" ]; then
    echo "Usage: ffci INPUT"
    echo "Outputs video file I-frames count."
    echo "Example: ffci input.mp4"
    return 1
  fi

  ffprobe $1 -select_streams v:0 -show_frames -v quiet | grep pict_type=I -c
}