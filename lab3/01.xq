(:Which movies have the genre "special"?:)
let $video := doc("videos.xml")/result/videos/video
(:let $videoTitle := doc("videos.xml")/result/videos/video[genre='special']/title:)
let $videoTitle := $video[genre='special']/title
return $videoTitle
