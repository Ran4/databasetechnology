(:Which director have the highest sum of user ratings?:)
let $videos := doc("videos.xml")/result/videos/video

let $highestsumdirectors := for $highestsumdirectors in distinct-values($videos/director)
        let $ratingsum := sum(
            for $director in distinct-values($videos/director)
                let $rating := $videos[director = $director]/user_rating
                where $director = $highestsumdirectors
                return $rating)
    order by $ratingsum descending
    return $highestsumdirectors
return $highestsumdirectors[1]
