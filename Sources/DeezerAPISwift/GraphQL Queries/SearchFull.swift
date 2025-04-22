//
//  SearchFull.swift
//  DeezerAPISwift
//
//  Created by Escher Wright-Dykhouse on 4/21/25.
//

extension DeezerGraphQLQueries {

    static let SearchFull: String = """
        query SearchFull($query: String!, $firstGrid: Int!, $firstList: Int!) {
          instantSearch(query: $query) {
            bestResult {
              __typename
              ... on InstantSearchAlbumBestResult {
                album {
                  ...SearchAlbum
                  __typename
                }
                __typename
              }
              ... on InstantSearchArtistBestResult {
                artist {
                  ...BestResultArtist
                  __typename
                }
                __typename
              }
              ... on InstantSearchPlaylistBestResult {
                playlist {
                  ...SearchPlaylist
                  __typename
                }
                __typename
              }
              ... on InstantSearchPodcastBestResult {
                podcast {
                  ...SearchPodcast
                  __typename
                }
                __typename
              }
              ... on InstantSearchLivestreamBestResult {
                livestream {
                  ...SearchLivestream
                  __typename
                }
                __typename
              }
              ... on InstantSearchTrackBestResult {
                track {
                  ...TableTrack
                  __typename
                }
                __typename
              }
              ... on InstantSearchPodcastEpisodeBestResult {
                podcastEpisode {
                  ...SearchPodcastEpisode
                  __typename
                }
                __typename
              }
            }
            results {
              artists(first: $firstGrid) {
                edges {
                  node {
                    ...SearchArtist
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              albums(first: $firstGrid) {
                edges {
                  node {
                    ...SearchAlbum
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              channels(first: $firstGrid) {
                edges {
                  node {
                    ...SearchChannel
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              flowConfigs(first: $firstGrid) {
                edges {
                  node {
                    ...SearchFlowConfig
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              livestreams(first: $firstGrid) {
                edges {
                  node {
                    ...SearchLivestream
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              playlists(first: $firstGrid) {
                edges {
                  node {
                    ...SearchPlaylist
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              podcasts(first: $firstGrid) {
                edges {
                  node {
                    ...SearchPodcast
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              tracks(first: $firstList) {
                edges {
                  node {
                    ...TableTrack
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              users(first: $firstGrid) {
                edges {
                  node {
                    ...SearchUser
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              podcastEpisodes(first: $firstList) {
                edges {
                  node {
                    ...SearchPodcastEpisode
                    __typename
                  }
                  __typename
                }
                pageInfo {
                  endCursor
                  __typename
                }
                priority
                __typename
              }
              __typename
            }
            __typename
          }
        }

        fragment SearchAlbum on Album {
          id
          displayTitle
          isFavorite
          releaseDateAlbum: releaseDate
          isExplicitAlbum: isExplicit
          cover {
            ...PictureLarge
            __typename
          }
          contributors {
            edges {
              roles
              node {
                ... on Artist {
                  id
                  name
                  __typename
                }
                __typename
              }
              __typename
            }
            __typename
          }
          tracksCount
          __typename
        }

        fragment PictureLarge on Picture {
          id
          large: urls(pictureRequest: {width: 500, height: 500})
          explicitStatus
          __typename
        }

        fragment BestResultArtist on Artist {
          ...SearchArtist
          hasSmartRadio
          hasTopTracks
          __typename
        }

        fragment SearchArtist on Artist {
          id
          isFavorite
          name
          fansCount
          picture {
            ...PictureLarge
            __typename
          }
          __typename
        }

        fragment SearchPlaylist on Playlist {
          id
          title
          isFavorite
          estimatedTracksCount
          fansCount
          picture {
            ...PictureLarge
            __typename
          }
          owner {
            id
            name
            __typename
          }
          __typename
        }

        fragment SearchPodcast on Podcast {
          id
          displayTitle
          isPodcastFavorite: isFavorite
          cover {
            ...PictureLarge
            __typename
          }
          isExplicit
          rawEpisodes
          __typename
        }

        fragment SearchLivestream on Livestream {
          id
          name
          cover {
            ...PictureLarge
            __typename
          }
          __typename
        }

        fragment TableTrack on Track {
          id
          title
          duration
          popularity
          isExplicit
          lyrics {
            id
            __typename
          }
          media {
            id
            rights {
              ads {
                available
                availableAfter
                __typename
              }
              sub {
                available
                availableAfter
                __typename
              }
              __typename
            }
            __typename
          }
          album {
            id
            displayTitle
            cover {
              ...PictureXSmall
              ...PictureLarge
              __typename
            }
            __typename
          }
          contributors {
            edges {
              node {
                ... on Artist {
                  id
                  name
                  __typename
                }
                __typename
              }
              __typename
            }
            __typename
          }
          __typename
        }

        fragment PictureXSmall on Picture {
          id
          xxx_small: urls(pictureRequest: {width: 40, height: 40})
          explicitStatus
          __typename
        }

        fragment SearchPodcastEpisode on PodcastEpisode {
          id
          title
          description
          duration
          releaseDate
          media {
            url
            __typename
          }
          podcast {
            id
            displayTitle
            isExplicit
            cover {
              ...PictureSmall
              ...PictureLarge
              __typename
            }
            rights {
              ads {
                available
                __typename
              }
              sub {
                available
                __typename
              }
              __typename
            }
            __typename
          }
          __typename
        }

        fragment PictureSmall on Picture {
          id
          small: urls(pictureRequest: {height: 100, width: 100})
          explicitStatus
          __typename
        }

        fragment SearchChannel on Channel {
          id
          picture {
            ...PictureLarge
            __typename
          }
          logoAsset {
            id
            large: urls(uiAssetRequest: {width: 500, height: 0})
            __typename
          }
          name
          slug
          backgroundColor
          __typename
        }

        fragment SearchFlowConfig on FlowConfig {
          id
          title
          visuals {
            dynamicPageIcon {
              id
              large: urls(uiAssetRequest: {width: 500, height: 500})
              __typename
            }
            __typename
          }
          __typename
        }

        fragment SearchUser on User {
          id
          name
          picture {
            ...PictureLarge
            __typename
          }
          __typename
        }
        """

}
