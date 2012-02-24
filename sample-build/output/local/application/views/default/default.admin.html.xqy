xquery version "1.0-ml";
declare default element namespace "http://www.w3.org/1999/xhtml";
<div id="admin-main">
   <div class="inner-page-title">
      <h2>Administration</h2>
   </div>
    <div class="clear"></div>
    <div class="content-box">
        <div class="two-column">
            <div class="column">
                <div class="box ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">                    
                    <div class="portlet-header ui-widget-header">Manage Authorities<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
                    <div id="notifications" class="portlet-content">
                        <ul class="side-menu">
                           <li><a class="btn ui-state-default ext-link ui-corner-all" href="/publicationGroups">
                              <span class="ui-icon ui-icon-mail-closed"></span>Manage Publication Groups
                           </a></li>
                           <li><a class="btn ui-state-default ext-link ui-corner-all" href="/publications">
                              <span class="ui-icon ui-icon-mail-closed"></span>Manage Publications
                           </a></li>
                           <a class="btn ui-state-default ext-link ui-corner-all" href="/issnCodes">
                              <span class="ui-icon ui-icon-extlink"></span>Manage ISSN Numbers
                           </a>
                           <a class="btn ui-state-default ext-link ui-corner-all" href="/countryCodes">
                              <span class="ui-icon ui-icon-extlink"></span>Manage Country Codes
                           </a>
                           <a class="btn ui-state-default ext-link ui-corner-all" href="/locales">
                              <span class="ui-icon ui-icon-extlink"></span>Manage Locales
                           </a>
                           <a class="btn ui-state-default ext-link ui-corner-all" href="/timezones">
                              <span class="ui-icon ui-icon-extlink"></span>Manage TimeZones
                           </a>
                       </ul>
                    </div>
                </div>
            </div>
            <div class="column column-right">
                <div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
                    <div class="portlet-header ui-widget-header">Manage Taxonomies<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
                    <div id="pending-tasks" class="portlet-content">                                  
                   </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="content-box">
        <div class="two-column">
            <div class="column">
                <div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">                    
                    <div class="portlet-header ui-widget-header">System Configuration<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
                    <div id="system" class="portlet-content">
                       
                    </div>
                </div>
            </div>
            <div class="column column-right">
                <div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
                    <div class="portlet-header ui-widget-header">Manage System Access<span class="ui-icon ui-icon-circle-arrow-s"></span></div>
                    <div id="users" class="portlet-content">                                  
                   </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>