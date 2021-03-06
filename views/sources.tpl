<!DOCTYPE html>
<html>

% include('head.tpl')

<body>
  % include('navbar-top.tpl')
  % include('alert.tpl')
  <p>&nbsp;</p>

  % checked_auth = in_grps.get('Authorized')
  <table width="100%">
    <tr>
      <td width="20%"><b>Authorized sources:</b></td>
      <td><label class="switch">
        <input id="chbox_auth_src" type="checkbox" onClick="server.auth_src_grp()" {{'checked="checked"' if checked_auth == 1 else ""}} >
        <span class="slider round"></span> </label>
      </td>
    </tr>
  </table>

  % if checked_auth == 1:
  <p>&nbsp;</p>
  % end

  <form id="auth_form" class="form-inline" style={{"display:block" if checked_auth == 1 else "display:none"}} align="right" >
    <input id="ae_user" type="text" value="{{ae_user}}" {{"placeholder=Login" if ae_user == '' else ""}} ></input>
    <input id="ae_pass" type="password" value="{{ae_pass}}" {{"placeholder=Password" if ae_pass == '' else ""}} ></input>
    <button id="btn_ae_auth" type="button" onClick="aeAuth()">OK</button>
  </form>
  
  % if checked_auth == 1:
  <p>&nbsp;</p>
  % end

  <script>
    function aeAuth() {
        usr = document.getElementById('ae_user').value;
        psw = document.getElementById('ae_pass').value;
        server.ae_auth_button(usr, psw);
    }
    function modalClose(winID) {
        document.getElementById(winID).style.display = "none";
    }
    function delSource(m3uName) {
        if (confirm(m3uName + ": delete this source?")) {
            server.del_m3u_source(m3uName);
            location.reload(true);
        }
    }
  </script>

  <table class="table" width="100%" border="2" id="auth_table" style={{"display:block" if checked_auth == 1 else "display:none"}} >

    <% tbl_head = '''
    <tr>
      <th width="4%" >Name</th>
      <th width="2%" >Enable</th> 
      <th width="2%" >Prio</th>
       <!-- <th width="2%" >Prio mode</th> -->
      <th width="2%" >Add channels</th>
      <th width="2%" >Update period</th>
      <th width="3%" >Update</th>
      <th width="3%" >Links</th>
    </tr>'''
    %>

    {{!tbl_head}}

    <!-- input_sources [ 0-srcName, 1-enabled, 2-grpName, 3-prio, 4-prioMode, 5-addCh, 6-updPeriod, 7-updDate, 8-links ] -->
    % for row in in_srcs:
    % if row[2] == 'Authorized':
    <tr>
      <!-- Name -->
      % ids = 'hrf_' + row[0]
      <td><a id={{ids}} {{'href=/inputs/'+row[0] if row[1] == 1 and row[8] > 0 else ""}} >{{row[0]}}</a></td>
      <!-- Enable -->
      <td><label class="switch">
        % ids = 'src_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[1] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Prio -->
      % ids = 'pri_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,21):
          <option {{'selected' if prio == row[3] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Prio mode 
      <td><label class="switch">
        % ids = 'pmd_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[4] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td> -->
      <!-- Add channels -->
      <td><label class="switch">
        % ids = 'ach_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[5] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Update period -->
      % ids = 'upr_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,9):
          <option {{'selected' if prio == row[6] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Update -->
      % ids_bt = 'ubt_' + row[0]
      % ids_lb = 'ulb_' + row[0]
      <td>
        <button class="btn" onClick="server.upd_src_button('{{ids_lb}}')" ><i id={{ids_bt}} class="fa fa-refresh"></i></button>
        <label id={{ids_lb}} >{{row[7]}}</label>
      </td>
      <!-- Links -->
      % ids = 'lks_' + row[0]
      <td>
        <label id={{ids}} >{{row[8]}}</label>
      </td>
    </tr>
    % end
    % end
  </table>

  % if checked_auth == 1:
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  % end

  <!-- SITES -->

  % checked_site = in_grps.get('Sites')
  <table width="100%">
    <tr>
      <td width="20%"><b>Site sources:</b></td>
      <td><label class="switch">
        <input id="chbox_site_src" type="checkbox" onClick="server.site_src_grp()" {{'checked="checked"' if checked_site == 1 else ""}} >
        <span class="slider round"></span> </label>
      </td>
    </tr>
  </table>

  % if checked_site == 1:
  <p>&nbsp;</p>
  % end

  <table class="table" width="100%" border="2" id="site_table" style={{"display:block" if checked_site == 1 else "display:none"}} >

    {{!tbl_head}}

    <!-- input_sources [ 0-srcName, 1-enabled, 2-grpName, 3-prio, 4-prioMode, 5-addCh, 6-updPeriod, 7-updDate, 8-links ] -->
    % for row in in_srcs:
    % if row[2] == 'Sites':
    <tr>
      <!-- Name -->
      % ids = 'hrf_' + row[0]
      <% 
         if 'HochuTV' in row[0] or 'AdultTV' in row[0]:
            title = row[0] + ' (18+)'
         else:
            title = row[0]
         end
      %>
        <td><a id={{ids}} {{'href=/inputs/'+row[0] if row[1] == 1 and row[8] > 0 else ""}} >{{title}}</a></td>
      <!-- Enable -->
      <td><label class="switch">
        % ids = 'src_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[1] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Prio -->
      % ids = 'pri_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,21):
          <option {{'selected' if prio == row[3] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Add channels -->
      <td><label class="switch">
        % ids = 'ach_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[5] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Update period -->
      % ids = 'upr_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,9):
          <option {{'selected' if prio == row[6] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Update -->
      % ids_bt = 'ubt_' + row[0]
      % ids_lb = 'ulb_' + row[0]
      <td>
        <button class="btn" onClick="server.upd_src_button('{{ids_lb}}')" ><i id={{ids_bt}} class="fa fa-refresh"></i></button>
        <label id={{ids_lb}} >{{row[7]}}</label>
      </td>
      <!-- Links -->
      % ids = 'lks_' + row[0]
      <td>
        <label id={{ids}} >{{row[8]}}</label>
      </td>
    </tr>
    % end
    % end
  </table>

  % if checked_site == 1:
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  % end

  <!-- M3U Playlists -->

  % include('add-m3u.tpl')

  % checked_m3u = in_grps.get('Playlists')
  <table width="100%">
    <tr>
      <td width="20%"><b>Playlists sources:</b></td>
      <td><label class="switch">
        <input id="chbox_m3u_src" type="checkbox" onClick="server.m3u_src_grp()" {{'checked="checked"' if checked_m3u == 1 else ""}} >
        <span class="slider round"></span> </label>
      </td>
    </tr>
  </table>

  % if checked_m3u == 1:
  <p>&nbsp;</p>

  <form id="auth_form" class="form-inline">
    <button id="btn_add_m3u" type="button" onClick="server.add_m3u_source()">Add playlist</button>
  </form>
  
  <p>&nbsp;</p>
  % end

  <table class="table" width="100%" border="2" id="m3u_table" style={{"display:block" if checked_m3u == 1 and is_m3u else "display:none"}} >

    {{!tbl_head}}

    <!-- input_sources [ 0-srcName, 1-enabled, 2-grpName, 3-prio, 4-prioMode, 5-addCh, 6-updPeriod, 7-updDate, 8-links, 9-srcUrl ] -->
    % for row in in_srcs:
    % if row[2] == 'Playlists':
    <tr>
      <!-- Name -->
      % ids = 'hrf_' + row[0]
        <td>
          <a id={{ids}} {{'href=/inputs/'+row[0] if row[1] == 1 and row[8] > 0 else ""}} >{{row[0]}}</a>
          <button class="btn" onClick="server.show_m3u_info('{{row[0]}}')" ><i class="fa fa-info-circle" style="font-size:26px;color:blue" ></i></button>
          <button class="btn" onClick="delSource('{{row[0]}}')" ><i class="fa fa-trash-o" style="font-size:26px;color:red" ></i></button>
        </td>
      <!-- Enable -->
      <td><label class="switch">
        % ids = 'src_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[1] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Prio -->
      % ids = 'pri_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,21):
          <option {{'selected' if prio == row[3] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Add channels -->
      <td><label class="switch">
        % ids = 'ach_' + row[0]
        <input id={{ids}} type="checkbox" onClick="server.click_switch('{{ids}}')" {{'checked="checked"' if row[5] == 1 else ""}} >
        <span class="slider round"></span></label>
      </td>
      <!-- Update period -->
      % ids = 'upr_' + row[0]
      <td><select id={{ids}} class="form-control" onchange="server.change_select('{{ids}}')" >
        % for prio in range(1,9):
          <option {{'selected' if prio == row[6] else ""}} >{{prio}}</option>
        % end
        </select>
      </td>
      <!-- Update -->
      % ids_bt = 'ubt_' + row[0]
      % ids_lb = 'ulb_' + row[0]
      <td>
        <button class="btn" onClick="server.upd_src_button('{{ids_lb}}')" ><i id={{ids_bt}} class="fa fa-refresh"></i></button>
        <label id={{ids_lb}} >{{row[7]}}</label>
      </td>
      <!-- Links -->
      % ids = 'lks_' + row[0]
      <td>
        <label id={{ids}} >{{row[8]}}</label>
      </td>
    </tr>
    % end
    % end
  </table>

  <p>&nbsp;</p>
  <p>&nbsp;</p>

</body>

</html>
