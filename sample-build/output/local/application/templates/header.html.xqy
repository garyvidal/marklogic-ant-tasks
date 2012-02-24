declare default element namespace "http://www.w3.org/1999/xhtml";
<div id="head">
    <div id="headLevel1">
        <img src="/resources/img/conde.png" alt="Conde Nast" />
        <h2>Digital Asset Management</h2>
        <div id="tools">
            <ul>
                <li class="welcome">Welcome <span class="name">Admin</span></li>
                <li>Settings</li>
                <li>My Account</li>
                <li>Logout</li>
            </ul>
        </div>
    </div>
    <div id="headLevel2">
        <?template name="navigation"?> 
        <div id="quicksearch">
            <form action="#" method="get" name="quickserach">
                <input type="text" name="q" />
                <input type="submit" value="Search" />
            </form>
        </div>
    </div>
</div> 