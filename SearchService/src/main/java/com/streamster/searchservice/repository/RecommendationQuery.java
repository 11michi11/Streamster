package com.streamster.searchservice.repository;

public class RecommendationQuery {
    final static String value = """
            MATCH (user:User{name:$username})
            OPTIONAL MATCH (user)-[cv:CreatesVideo]->(createdVideo:Video)
            WITH user,collect(createdVideo.videoId) as createdVideoIds
            OPTIONAL MATCH (user)-[wv:WatchesVideo]->(watchedVideo:Video)
            WITH user,collect({watchedVideo:watchedVideo,wv:wv}) as watchedVideos, collect(watchedVideo.videoId)+createdVideoIds as videoIdsToExclude
            WITH user,watchedVideos,CASE WHEN videoIdsToExclude = [] THEN [null] ELSE videoIdsToExclude END AS videoIdsToExclude\s
            UNWIND videoIdsToExclude as videoIdToExclude
            WITH user, watchedVideos, collect(DISTINCT videoIdToExclude) as videoIdsToExclude
                        
            CALL {
            	WITH user
            	MATCH (user)-[psp:PrefersStudyProgram]->(sp:StudyProgram)
            	MATCH (sp)<-[:HasStudyProgram]-(videoFromStudyProgram:Video)
            	RETURN collect({video:videoFromStudyProgram,priority:psp.priority}) as videosFromStudyProgram
            }
            CALL {
            	WITH user
                MATCH (user)-[pt:PrefersTag]->(tag:Tag)
                MATCH (tag)<-[:HasTag]-(videoFromTag:Video)
                RETURN collect({video:videoFromTag,priority:pt.priority}) as videosFromTag
            }
            CALL {
            	WITH user
                MATCH (user)-[pl:PrefersLength]->(interval:LengthInterval)
            	MATCH (videoFromLength:Video)\s
                	WHERE (NOT EXISTS (interval.to) OR interval.to >= videoFromLength.length)\s
                    		AND (NOT EXISTS (interval.from) OR interval.from <= videoFromLength.length)
            	RETURN collect({video:videoFromLength,priority:pl.priority}) as videosFromLength
            }
            CALL {
            	WITH user,watchedVideos,videoIdsToExclude
            	UNWIND watchedVideos as watchedVideo
            	WITH user, watchedVideo.watchedVideo as watchedVideo, watchedVideo.wv as wv, videoIdsToExclude
                MATCH (watchedVideo)-[:HasStudyProgram]->(spFromWatch:StudyProgram)
                MATCH (watchedVideo)-[:HasTag]->(tagFromWatch:Tag)
                OPTIONAL MATCH (videoFromWatchSP:Video)-[:HasStudyProgram]->(spFromWatch)\s
                	WHERE NOT videoFromWatchSP.videoId IN videoIdsToExclude
                OPTIONAL MATCH (videoFromWatchTag:Video)-[:HasTag]->(tagFromWatch)\s
                	WHERE NOT videoFromWatchTag.videoId IN videoIdsToExclude
                WITH collect(DISTINCT videoFromWatchSP)
                    +collect(DISTINCT videoFromWatchTag)\s
                        as videosFromWatch,wv
                UNWIND videosFromWatch as videoFromWatch
                WITH DISTINCT videoFromWatch,wv
                WITH videoFromWatch,wv,wv.priority-duration.InMonths(date(wv.time),date()).months as priorityFromWatch
                WHERE priorityFromWatch > 0
                WITH videoFromWatch,Sum(priorityFromWatch) as priorityFromWatch
                RETURN collect(DISTINCT {video:videoFromWatch,priority:priorityFromWatch}) as videosFromWatch
            }
            CALL {
            	WITH user
                MATCH (user)-[lv:LikesVideo]->(likedVideo:Video)
                MATCH (likedVideo)-[:HasStudyProgram]->(spFromLike:StudyProgram)
                MATCH (likedVideo)-[:HasTag]->(tagFromLike:Tag)
                OPTIONAL MATCH (videoFromLikeSP:Video)-[:HasStudyProgram]->(spFromLike) WHERE NOT likedVideo.videoId = videoFromLikeSP.videoId
                OPTIONAL MATCH (videoFromLikeTag:Video)-[:HasTag]->(tagFromLike) WHERE NOT likedVideo.videoId = videoFromLikeTag.videoId
                WITH collect(DISTINCT videoFromLikeSP)
                    +collect(DISTINCT videoFromLikeTag)\s
                        as videosFromLike,lv
                UNWIND videosFromLike as videoFromLike
                WITH DISTINCT videoFromLike,lv
                WITH videoFromLike,lv,lv.priority-duration.InMonths(date(lv.time),date()).months as priorityFromLike
                WHERE priorityFromLike > 0
                WITH videoFromLike,Sum(priorityFromLike) as priorityFromLike
                RETURN collect(DISTINCT {video:videoFromLike,priority:priorityFromLike}) as videosFromLike
            }
            CALL {
            	WITH user
                MATCH (user)-[dv:DislikesVideo]->(dislikedVideo:Video)
                MATCH (dislikedVideo)-[:HasStudyProgram]->(spFromDislike:StudyProgram)
                MATCH (dislikedVideo)-[:HasTag]->(tagFromDislike:Tag)
                OPTIONAL MATCH (videoFromDislikeSP:Video)-[:HasStudyProgram]->(spFromDislike) WHERE NOT dislikedVideo.videoId = videoFromDislikeSP.videoId
                OPTIONAL MATCH (videoFromDislikeTag:Video)-[:HasTag]->(tagFromDislike) WHERE NOT dislikedVideo.videoId = videoFromDislikeTag.videoId
                WITH collect(DISTINCT videoFromDislikeSP)
                    +collect(DISTINCT videoFromDislikeTag)\s
                        as videosFromDislike,dv
                UNWIND videosFromDislike as videoFromDislike
                WITH DISTINCT videoFromDislike,dv
                WITH videoFromDislike,dv,dv.priority+duration.InMonths(date(dv.time),date()).months as priorityFromDislike
                WHERE priorityFromDislike < 0
                WITH videoFromDislike,Sum(priorityFromDislike) as priorityFromDislike
                RETURN collect(DISTINCT {video:videoFromDislike,priority:priorityFromDislike}) as videosFromDislike
            }
            CALL {
            	WITH user
                MATCH (user)-[cpv:CommentsPositiveVideo]->(commentedPosVideo:Video)
                MATCH (commentedPosVideo)-[:HasStudyProgram]->(spFromCommentPos:StudyProgram)
                MATCH (commentedPosVideo)-[:HasTag]->(tagFromCommentPos:Tag)
                OPTIONAL MATCH (videoFromCommentPosSP:Video)-[:HasStudyProgram]->(spFromCommentPos) WHERE NOT commentedPosVideo.videoId = videoFromCommentPosSP.videoId
                OPTIONAL MATCH (videoFromCommentPosTag:Video)-[:HasTag]->(tagFromCommentPos) WHERE NOT commentedPosVideo.videoId = videoFromCommentPosTag.videoId
                WITH collect(DISTINCT videoFromCommentPosSP)
                    +collect(DISTINCT videoFromCommentPosTag)\s
                        as videosFromCommentPos,cpv
                UNWIND videosFromCommentPos as videoFromCommentPos
                WITH DISTINCT videoFromCommentPos,cpv
                WITH videoFromCommentPos,cpv,cpv.priority-duration.InMonths(date(cpv.time),date()).months as priorityFromCommentPos
                WHERE priorityFromCommentPos > 0
                WITH videoFromCommentPos,Sum(priorityFromCommentPos) as priorityFromCommentPos
                RETURN collect(DISTINCT {video:videoFromCommentPos,priority:priorityFromCommentPos}) as videosFromCommentPositive
            }
            CALL {
            	WITH user
                MATCH (user)-[cnv:CommentsNegativeVideo]->(commentedNegVideo:Video)
                MATCH (commentedNegVideo)-[:HasStudyProgram]->(spFromCommentNeg:StudyProgram)
                MATCH (commentedNegVideo)-[:HasTag]->(tagFromCommentNeg:Tag)
                OPTIONAL MATCH (videoFromCommentNegSP:Video)-[:HasStudyProgram]->(spFromCommentNeg) WHERE NOT commentedNegVideo.videoId = videoFromCommentNegSP.videoId
                OPTIONAL MATCH (videoFromCommentNegTag:Video)-[:HasTag]->(tagFromCommentNeg) WHERE NOT commentedNegVideo.videoId = videoFromCommentNegTag.videoId
                WITH collect(DISTINCT videoFromCommentNegSP)
                    +collect(DISTINCT videoFromCommentNegTag)\s
                        as videosFromCommentNeg,cnv
                UNWIND videosFromCommentNeg as videoFromCommentNeg
                WITH DISTINCT videoFromCommentNeg,cnv
                WITH videoFromCommentNeg,cnv,cnv.priority+duration.InMonths(date(cnv.time),date()).months as priorityFromCommentNeg
                WHERE priorityFromCommentNeg < 0
                WITH videoFromCommentNeg,Sum(priorityFromCommentNeg) as priorityFromCommentNeg
                RETURN collect(DISTINCT {video:videoFromCommentNeg,priority:priorityFromCommentNeg}) as videosFromCommentNegative
            }
            CALL {
            	WITH user
            	MATCH (user)-[sv:SearchesVideo]->(searchTerm:SearchTerm)
            	CALL db.index.fulltext.queryNodes("search", searchTerm.name) YIELD node, score
            	WITH\s
                    score,
                    sv,
                    CASE node:Video WHEN true THEN node ELSE null END AS videoFromSearch,
                    CASE node:Tag WHEN true THEN node ELSE null END AS tagFromSearch,
                    CASE node:StudyProgram WHEN true THEN node ELSE null END AS spFromSearch
            	
                OPTIONAL MATCH (videoFromSearchSP:Video)-[:HasStudyProgram]->(spFromSearch)
                OPTIONAL MATCH (videoFromSearchTag:Video)-[:HasTag]->(tagFromSearch)
                WITH collect(DISTINCT videoFromSearchSP)
                    +collect(DISTINCT videoFromSearchTag)
                    +collect(videoFromSearch)
                    as videosFromSearch,sv
                UNWIND videosFromSearch as videoFromSearch
                WITH videoFromSearch,sv.priority as priorityFromSearch
                WHERE priorityFromSearch > 0
                WITH videoFromSearch,Sum(priorityFromSearch) as priorityFromSearch
                RETURN collect(DISTINCT {video:videoFromSearch,priority:priorityFromSearch}) as videosFromSearch
            }
                        
            WITH videosFromStudyProgram
            	+videosFromTag
            	+videosFromLength
                +videosFromWatch
                +videosFromLike
                +videosFromDislike
            	+videosFromCommentPositive
            	+videosFromCommentNegative
                +videosFromSearch
                as videos,
                videoIdsToExclude
            UNWIND videos as v\s
            WITH v,videoIdsToExclude
            WHERE NOT v.video.videoId IN videoIdsToExclude
            WITH v.video.videoId as videoId, Sum(v.priority) as priority ORDER BY priority DESC, videoId ASC
            RETURN videoId""";
}
