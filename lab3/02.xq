(:Which director has directed at least two movies,
and which movies has he directed?:)
let $nl := "&#10;"

let $video := doc("videos.xml")/result/videos/video
(:for $director in $video/director:)
(:return $director:)
(:let $videoTitle := $video[count($video/director) >= 2]/title:)
for $director in doc("videos.xml")/result/videos/video/director
let $n := count($video/director)
where ($n > 1)

(:for $video in doc("videos.xml")/result/videos/video:)
(:where $video[count(director) >= 2]:)
(:where count($video/director >= 2):)
(:let $videoTitle := $video/title:)
(:  return concat($nl,$videoTitle) :)
(:return $videoTitle:)
return $director
