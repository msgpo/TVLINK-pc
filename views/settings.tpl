<!DOCTYPE html>
<html>

% include('head.tpl')

<body>
  % include('navbar-top.tpl')
  % include('alert.tpl')
  <p>&nbsp;</p>

  <script>
    function modalClose(winID) {
        document.getElementById(winID).style.display = "none";
    }
  </script>

    <% tbl_head = '''
    <tr>
      <th width="10%" >Option</th>
      <th width="3%" >Value</th>
    </tr>'''
    %>

  <h4><b>Service settings:</b></h4>
  <p>&nbsp;</p>

  <div style="overflow:hidden;_zoom:1">

    <table class="table" border="2" style="float:left;width:49%;display:block" >

      {{!tbl_head}}

      <!-- Port -->
      <tr>
        <td >
          <label class="form-control">Server Port</label>
        </td>
        <td>
          <input id="srv_port" class="form-control" type="text" value="{{PORT}}" onchange="server.set_port()" >
        </td>
      </tr>
      <!-- IP -->
      <tr>
        <td>
          <label class="form-control">Playlist IP</label>
        </td>
        <td>
          <input id="pls_ip" class="form-control" type="text" value="{{IP}}" onchange="server.set_ip()" >
        </td>
      </tr>
      <!-- Auto IP -->
      <tr>
        <td>
          <label class="form-control">Auto playlist IP</label>
        </td>
        <td><label class="switch">
          <input id="aut_ip" type="checkbox" onClick="server.auto_ip()" {{'checked="checked"' if not auto_ip == 'false' else ""}} >
          <span class="slider round"></span></label>
        </td>
      </tr>

    </table>

    <table class="table" border="2" style="float:right;width:49%;display:block" >

      {{!tbl_head}}

      <!-- Refresh startup -->
      <tr>
        <td>
          <label class="form-control">Refresh sources at startup</label>
        </td>
        <td><label class="switch">
          <input id="upd_ch_start" type="checkbox" onClick="server.update_ch_startup()" {{'checked="checked"' if upd_ch_start == 'true' else ""}} >
          <span class="slider round"></span></label>
        </td>
      </tr>
      <!-- Refresh startup -->
      <tr>
        <td>
          <label class="form-control">Refresh sources at playlist</label>
        </td>
        <td><label class="switch">
          <input id="upd_ch_list" type="checkbox" onClick="server.update_ch_list()" {{'checked="checked"' if upd_ch_list == 'true' else ""}} >
          <span class="slider round"></span></label>
        </td>
      </tr>
      <!-- Remove channels -->
      <tr>
        <td>
          <label class="form-control">Remove broken channels</label>
        </td>
        <td><label class="switch">
          <input id="del_ch_broken" type="checkbox" onClick="server.del_broken_channel()" {{'checked="checked"' if del_ch == 'true' else ""}} >
          <span class="slider round"></span></label>
        </td>
      </tr>

    </table>

  </div>

  <p>&nbsp;</p>
  <h4><b>Streamer settings:</b></h4>
  <p>&nbsp;</p>

  <form class="form-inline" >
    <label class="form-control"><b>Main User-Agent:</b></label>
    <input id="usr_agent" size="50%" class="form-control" value="{{usr_agent}}" onchange="server.set_usr_agent()">
  </form>
  <p>&nbsp;</p>

  <div style="overflow:hidden;_zoom:1">

    <table class="table" border="2" style="float:left;width:49%;display:block" >

      {{!tbl_head}}

      <!-- TS Buffer -->
      <tr>
        <td >
          <label class="form-control">TS buffer (Mb)</label>
        </td>
        <td>
          <select id="ts_buffer" class="form-control" onchange="server.setting_options('ts_buffer')" >
            % for tbuf in range(1,21):
            <option {{'selected' if tbuf == int(ts_buffer) else ""}} >{{tbuf}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HLS Buffer -->
      <tr>
        <td>
          <label class="form-control">HLS buffer (Mb)</label>
        </td>
        <td>
          <select id="hls_buffer" class="form-control" onchange="server.setting_options('hls_buffer')" >
            % for hbuf in range(1,21):
            <option {{'selected' if hbuf == int(hls_buffer) else ""}} >{{hbuf}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HTTP Timeout -->
      <tr>
        <td>
          <label class="form-control">HTTP timeout (sec)</label>
        </td>
        <td>
          <select id="http_timeout" class="form-control" onchange="server.setting_options('http_timeout')" >
            % for ht_tout in range(1,21):
            <option {{'selected' if ht_tout == int(http_timeout) else ""}} >{{ht_tout}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HLS Segment Timeout -->
      <tr>
        <td>
          <label class="form-control">HLS segment timeout (sec)</label>
        </td>
        <td>
          <select id="hls_timeout" class="form-control" onchange="server.setting_options('hls_timeout')" >
            % for hl_tout in range(1,21):
            <option {{'selected' if hl_tout == int(hls_timeout) else ""}} >{{hl_tout}}</option>
            % end
          </select>
        </td>
      </tr>

    </table>

    <table class="table" border="2" style="float:right;width:49%;display:block" >

      {{!tbl_head}}

      <!-- HLS Live Edge -->
      <tr>
        <td>
          <label class="form-control">HLS live edge</label>
        </td>
        <td>
          <select id="hls_live_edge" class="form-control" onchange="server.setting_options('hls_live_edge')" >
            % for edge in range(1,11):
            <option {{'selected' if edge == int(hls_live_edge) else ""}} >{{edge}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HLS Segment Threads -->
      <tr>
        <td>
          <label class="form-control">HLS segment threads</label>
        </td>
        <td>
          <select id="hls_segment_threads" class="form-control" onchange="server.setting_options('hls_segment_threads')" >
            % for thrd in range(1,11):
            <option {{'selected' if thrd == int(hls_segment_threads) else ""}} >{{thrd}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HLS Playlist Reload Time -->
      <tr>
        <td>
          <label class="form-control">HLS playlist reload time</label>
        </td>
        <td>
          <select id="hls_playlist_reload_time" class="form-control" onchange="server.setting_options('hls_playlist_reload_time')" >
            % for rltime in ['default', 'duration', 'segment', 'average']:
            <option {{'selected' if rltime == hls_playlist_reload_time else ""}} >{{rltime}}</option>
            % end
          </select>
        </td>
      </tr>
      <!-- HLS Segment Stream Data -->
      <tr>
        <td>
          <label class="form-control">HLS segment stream data</label>
        </td>
        <td><label class="switch">
          <input id="hls_stream_data" type="checkbox" onClick="server.set_hls_stream_data()" {{'checked="checked"' if hls_stream_data == 'True' else ""}} >
          <span class="slider round"></span></label>
        </td>
      </tr>

    </table>

  </div>

  <p>&nbsp;</p>

  <form class="form-inline">
    <label class="form-control"><b>Sources Proxy:</b></label>
    <input id="src_proxy" size="47%" class="form-control" type="text" value="{{proxy_url}}" onchange="server.set_proxy()"></input>
  </form>

  <p>&nbsp;</p>

  <form class="form-inline">
    <label class="form-control"><b>License key:</b></label>
    <input id="lic_key" size="50%" class="form-control" type="password" value="{{lic_key}}"></input>
    <button id="btn_ae_auth" type="button" onClick="server.set_lickey()">OK</button>
  </form>

  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>

  <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-bottom">
    <div class="container justify-content-center"> <button class="navbar-toggler navbar-toggler-right border-0" type="button" data-toggle="collapse" data-target="#navbar_bottom">
        <span class="navbar-toggler-icon"></span>
      </button>
      <a href="/reload" id="countCH" style="font-size:20px;color:white;font-weight:bold;">Reload program</a>
    </div>
  </nav>



</body>

</html>
