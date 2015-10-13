(:Which director has directed at least two movies, and
which movies has he directed?:)
let $nl := "&#10;"
let $video := doc("videos.xml")/result/videos/video

for $director in distinct-values($video/director)
    let $titlesfromcommondirector :=
        $video[director = $director]/title
        where count($video/director[. = $director]) >= 2
where count($video/director[. = $director]) >= 2



(:as multiple lines:)
(:let $titlesfromcommondirectorformatted :=
    for $title in $titlesfromcommondirector
        return concat($nl, " ", $title)
return <movie director="{$director}">{$titlesfromcommondirectorformatted}</movie>:)


(:as a single line:)
return <movie director="{$director}">{$titlesfromcommondirector}</movie>
