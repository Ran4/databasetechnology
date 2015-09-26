let $nl := "&#10;"
let $video := (doc("videos.xml")/result/videos/video)
(:let $genre := $video/genre:)
(:for $videoTitle in $video/title where $video/genre = "special" :)
(:for $videoGenre in $video/genre where ($video/genre="special"):)
let $videoTitle := $video/title
where $video/genre = "special"
(:  return concat($nl,$videoTitle) :)
return $videoTitle
