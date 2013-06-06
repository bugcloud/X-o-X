class App
  constructor: () ->
    @albums = []
    @$view = $("#main")
  setAlbums: (data) ->
    @albums = data
  initWithAlbums: (data) ->
    @setAlbums data
    html = """
      <table id='table-albums' class='table'>
        <thead>
          <tr>
            <th>Album</th>
            <th>Representative Track</th>
            <th>Genre</th>
            <th>Play Count</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    """
    @$view.append html
    $tableBody = $("#table-albums tbody")
    for album in @albums
      row = "<tr><td>"
      if album.MPMediaItemPropertyArtwork?
        row = "#{row}<img src='data:image/jpeg;base64,#{album.MPMediaItemPropertyArtwork}'>"
      row = """
          #{row}<div>#{_.escape album.MPMediaItemPropertyAlbumTitle}</div><div>#{_.escape album.MPMediaItemPropertyArtist}</div></td>
          <td>#{_.escape album.MPMediaItemPropertyTitle}</td>
          <td>#{_.escape album.MPMediaItemPropertyGenre}</td>
          <td>#{_.escape album.MPMediaItemPropertyPlayCount}</td>
        </tr>
      """
      $tableBody.append row

window._app = new App
