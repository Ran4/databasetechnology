(:Which director has directed at least two movies,
and which movies has he directed?:)
let $nl := "&#10;"

let $video := doc("videos.xml")/result/videos/video
(:for $director in $video/director:)
(:return $director:)
(:let $videoTitle := $video[count($video/director) >= 2]/title:)
for $director in doc("videos.xml")/result/videos/video/director
where (count($video/director) > 1)

(:for $director in doc("videos.xml")/result/videos/video[count(director) >= 2]/director:)

(:for $video in doc("videos.xml")/result/videos/video:)
(:where $video[count(director) >= 2]:)
(:where count($video/director >= 2):)
(:let $videoTitle := $video/title:)
(:  return concat($nl,$videoTitle) :)
(:return $videoTitle:)
(:return $director:)
return $video[count($video/director) > 1]/director
