#!/usr/bin/python
#coding=utf8
import urllib
import sys
import re
import xml.dom.minidom as xml

API_URL = 'http://dict.cn/ws.php?utf8=true&q=%s'
#API_URL = 'http://dict-co.iciba.com/api/dictionary.php?w=%s'
def getword(word):
    xmls = urllib.urlopen(API_URL%urllib.quote(word)).read()
    #print xmls
    root = xml.parseString(xmls).documentElement
    #print re.sub(u'>', '>\n',xmls)

    #tags = {'key':'单词', 'pron':'音标', 'def':'释义', 'sent':'例句', 'orig':'例句', 'trans':'翻译', 'acceptation':'释义'}
    tags = {'key':'单词', 'ps':'音标', 'def':'释义', 'sent':'例句', 'orig':'例句', 'trans':'翻译', 'acceptation':'释义'}

    def isElement(node):
        return node.nodeType == node.ELEMENT_NODE
    def isText(node):
        return node.nodeType == node.TEXT_NODE
    def show(node, tagName=None):
        if isText(node):
            tag = tags.get(tagName, tagName)
            print '%s:%s'%(tag, node.nodeValue)
        elif isElement(node) and tags.has_key(node.tagName):
            [show(i, node.tagName) for i in node.childNodes]

    [ show(i) for i in root.childNodes if isElement(i) ]
    
def main():
    if len(sys.argv) >= 2:
        word = ' '.join(sys.argv[1:])
        getword(word)
    else:
        print 'usage:dict [word]'


if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf8')
    main()


#<!DOCTYPE html>
#<html>
#  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
#    <meta charset='utf-8'>
#    <meta http-equiv="X-UA-Compatible" content="IE=edge">
#        <title>code/python/dict/dict.py at master from panweizeng/home - GitHub</title>
#    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
#    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
#    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
#
#    
#    
#
#    <meta content="authenticity_token" name="csrf-param" />
#<meta content="4DkVTBjtrnhue7MX37e1eWRFQeE60SR327BFagI11ZM=" name="csrf-token" />
#
#    <link href="https://a248.e.akamai.net/assets.github.com/stylesheets/bundles/github-635c55c6c80d55d386ec4d51a5ed208d1df48a84.css" media="screen" rel="stylesheet" type="text/css" />
#    <link href="https://a248.e.akamai.net/assets.github.com/stylesheets/bundles/github2-13857c19d377357ca8ae2019f06ebb53dd2e29cf.css" media="screen" rel="stylesheet" type="text/css" />
#    
#
#    <script src="https://a248.e.akamai.net/assets.github.com/javascripts/bundles/jquery-b2ca07cb3c906ceccfd58811b430b8bc25245926.js" type="text/javascript"></script>
#    <script src="https://a248.e.akamai.net/assets.github.com/javascripts/bundles/github-21f6af222f5b2bba17d8f64ecfd93c526738f876.js" type="text/javascript"></script>
#    
#
#      <link rel='permalink' href='/panweizeng/home/blob/84bf3ec006f8bccb532eb70386a0b35c7544687c/code/python/dict/dict.py'>
#    <meta property="og:title" content="home"/>
#    <meta property="og:type" content="githubog:gitrepository"/>
#    <meta property="og:url" content="https://github.com/panweizeng/home"/>
#    <meta property="og:image" content="https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png?1329275856"/>
#    <meta property="og:site_name" content="GitHub"/>
#    <meta property="og:description" content="home - some code"/>
#
#    <meta name="description" content="home - some code" />
#  <link href="https://github.com/panweizeng/home/commits/master.atom" rel="alternate" title="Recent Commits to home:master" type="application/atom+xml" />
#
#  </head>
#
#
#  <body class="logged_out page-blob linux vis-public env-production " data-blob-contribs-enabled="no">
#    
#
#
#    
#
#      <div id="header" class="true clearfix">
#        <div class="container clearfix">
#          <a class="site-logo" href="https://github.com">
#            <!--[if IE]>
#            <img alt="GitHub" class="github-logo" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7.png?1323882716" />
#            <img alt="GitHub" class="github-logo-hover" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7-hover.png?1324325358" />
#            <![endif]-->
#            <img alt="GitHub" class="github-logo-4x" height="30" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7@4x.png?1323882716" />
#            <img alt="GitHub" class="github-logo-4x-hover" height="30" src="https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7@4x-hover.png?1324325358" />
#          </a>
#
#                  <!--
#      make sure to use fully qualified URLs here since this nav
#      is used on error pages on other domains
#    -->
#    <ul class="top-nav logged_out">
#        <li class="pricing"><a href="https://github.com/plans">Signup and Pricing</a></li>
#        <li class="explore"><a href="https://github.com/explore">Explore GitHub</a></li>
#      <li class="features"><a href="https://github.com/features">Features</a></li>
#        <li class="blog"><a href="https://github.com/blog">Blog</a></li>
#      <li class="login"><a href="https://github.com/login?return_to=%2Fpanweizeng%2Fhome%2Fblob%2Fmaster%2Fcode%2Fpython%2Fdict%2Fdict.py">Login</a></li>
#    </ul>
#
#
#
#          
#        </div>
#      </div>
#
#      
#
#            <div class="site">
#      <div class="container">
#        <div class="pagehead repohead instapaper_ignore readability-menu">
#        <div class="title-actions-bar">
#          <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
#<a href="/panweizeng" itemprop="url">            <span itemprop="title">panweizeng</span>
#            </a> /
#            <strong><a href="/panweizeng/home" class="js-current-repository">home</a></strong>
#          </h1>
#          
#
#
#
#              <ul class="pagehead-actions">
#
#
#          <li><a href="/login?return_to=%2Fpanweizeng%2Fhome" class="minibutton btn-watch watch-button entice tooltipped leftwards" rel="nofollow" title="You must be logged in to use this feature"><span><span class="icon"></span>Watch</span></a></li>
#          <li><a href="/login?return_to=%2Fpanweizeng%2Fhome" class="minibutton btn-fork fork-button entice tooltipped leftwards" rel="nofollow" title="You must be logged in to use this feature"><span><span class="icon"></span>Fork</span></a></li>
#
#
#      <li class="repostats">
#        <ul class="repo-stats">
#          <li class="watchers ">
#            <a href="/panweizeng/home/watchers" title="Watchers" class="tooltipped downwards">
#              3
#            </a>
#          </li>
#          <li class="forks">
#            <a href="/panweizeng/home/network" title="Forks" class="tooltipped downwards">
#              2
#            </a>
#          </li>
#        </ul>
#      </li>
#    </ul>
#
#        </div>
#
#          
#
#  <ul class="tabs">
#    <li><a href="/panweizeng/home" class="selected" highlight="repo_sourcerepo_downloadsrepo_commitsrepo_tagsrepo_branches">Code</a></li>
#    <li><a href="/panweizeng/home/network" highlight="repo_networkrepo_fork_queue">Network</a>
#    <li><a href="/panweizeng/home/pulls" highlight="repo_pulls">Pull Requests <span class='counter'>0</span></a></li>
#
#      <li><a href="/panweizeng/home/issues" highlight="repo_issues">Issues <span class='counter'>0</span></a></li>
#
#      <li><a href="/panweizeng/home/wiki" highlight="repo_wiki">Wiki <span class='counter'>1</span></a></li>
#
#    <li><a href="/panweizeng/home/graphs" highlight="repo_graphsrepo_contributors">Stats &amp; Graphs</a></li>
#
#  </ul>
#
#  
#<div class="frame frame-center tree-finder" style="display:none"
#      data-tree-list-url="/panweizeng/home/tree-list/84bf3ec006f8bccb532eb70386a0b35c7544687c"
#      data-blob-url-prefix="/panweizeng/home/blob/84bf3ec006f8bccb532eb70386a0b35c7544687c"
#    >
#
#  <div class="breadcrumb">
#    <span class="bold"><a href="/panweizeng/home">home</a></span> /
#    <input class="tree-finder-input js-navigation-enable" type="text" name="query" autocomplete="off" spellcheck="false">
#  </div>
#
#    <div class="octotip">
#      <p>
#        <a href="/panweizeng/home/dismiss-tree-finder-help" class="dismiss js-dismiss-tree-list-help" title="Hide this notice forever" rel="nofollow">Dismiss</a>
#        <span class="bold">Octotip:</span> You've activated the <em>file finder</em>
#        by pressing <span class="kbd">t</span> Start typing to filter the
#        file list. Use <span class="kbd badmono">↑</span> and
#        <span class="kbd badmono">↓</span> to navigate,
#        <span class="kbd">enter</span> to view files.
#      </p>
#    </div>
#
#  <table class="tree-browser" cellpadding="0" cellspacing="0">
#    <tr class="js-header"><th>&nbsp;</th><th>name</th></tr>
#    <tr class="js-no-results no-results" style="display: none">
#      <th colspan="2">No matching files</th>
#    </tr>
#    <tbody class="js-results-list js-navigation-container">
#    </tbody>
#  </table>
#</div>
#
#<div id="jump-to-line" style="display:none">
#  <h2>Jump to Line</h2>
#  <form>
#    <input class="textfield" type="text">
#    <div class="full-button">
#      <button type="submit" class="classy">
#        <span>Go</span>
#      </button>
#    </div>
#  </form>
#</div>
#
#
#<div class="subnav-bar">
#
#  <ul class="actions subnav">
#    <li><a href="/panweizeng/home/tags" class="blank" highlight="repo_tags">Tags <span class="counter">0</span></a></li>
#    <li><a href="/panweizeng/home/downloads" class="blank downloads-blank" highlight="repo_downloads">Downloads <span class="counter">0</span></a></li>
#    
#  </ul>
#
#  <ul class="scope">
#    <li class="switcher">
#
#      <div class="context-menu-container js-menu-container">
#        <a href="#"
#           class="minibutton bigger switcher js-menu-target js-commitish-button btn-branch repo-tree"
#           data-master-branch="master"
#           data-ref="master">
#          <span><span class="icon"></span><i>branch:</i> master</span>
#        </a>
#
#        <div class="context-pane commitish-context js-menu-content">
#          <a href="javascript:;" class="close js-menu-close"></a>
#          <div class="context-title">Switch Branches/Tags</div>
#          <div class="context-body pane-selector commitish-selector js-filterable-commitishes">
#            <div class="filterbar">
#              <div class="placeholder-field js-placeholder-field">
#                <label class="placeholder" for="context-commitish-filter-field" data-placeholder-mode="sticky">Filter branches/tags</label>
#                <input type="text" id="context-commitish-filter-field" class="commitish-filter" />
#              </div>
#
#              <ul class="tabs">
#                <li><a href="#" data-filter="branches" class="selected">Branches</a></li>
#                <li><a href="#" data-filter="tags">Tags</a></li>
#              </ul>
#            </div>
#
#              <div class="commitish-item branch-commitish selector-item">
#                <h4>
#                    <a href="/panweizeng/home/blob/master/code/python/dict/dict.py" data-name="master" rel="nofollow">master</a>
#                </h4>
#              </div>
#
#
#            <div class="no-results" style="display:none">Nothing to show</div>
#          </div>
#        </div><!-- /.commitish-context-context -->
#      </div>
#
#    </li>
#  </ul>
#
#  <ul class="subnav with-scope">
#
#    <li><a href="/panweizeng/home" class="selected" highlight="repo_source">Files</a></li>
#    <li><a href="/panweizeng/home/commits/master" highlight="repo_commits">Commits</a></li>
#    <li><a href="/panweizeng/home/branches" class="" highlight="repo_branches" rel="nofollow">Branches <span class="counter">1</span></a></li>
#  </ul>
#
#</div>
#
#  
#  
#  
#
#
#          
#
#        </div><!-- /.repohead -->
#
#        
#
#
#
#
#    
#  <p class="last-commit">Latest commit to the <strong>master</strong> branch</p>
#
#<div class="commit commit-tease js-details-container">
#    <a href="/panweizeng/home/commit/84bf3ec006f8bccb532eb70386a0b35c7544687c" anchor="comments" class="comment-count">1 comment</a>
#  <p class="commit-title ">
#      <a href="/panweizeng/home/commit/84bf3ec006f8bccb532eb70386a0b35c7544687c" class="message">update dict and proxy script</a>
#      
#  </p>
#  <div class="commit-meta">
#    <a href="/panweizeng/home/commit/84bf3ec006f8bccb532eb70386a0b35c7544687c" class="sha-block">commit <span class="sha">84bf3ec006</span></a>
#    <span class="js-clippy clippy-button " data-clipboard-text="84bf3ec006f8bccb532eb70386a0b35c7544687c" data-copied-hint="copied!" data-copy-hint="Copy SHA"></span>
#
#    <div class="authorship">
#      <img class="gravatar" height="20" src="https://secure.gravatar.com/avatar/b8feb83230c117fad309a165e5859658?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png" width="20" />
#      <span class="author-name"><a href="/panweizeng">panweizeng</a></span>
#      authored <time class="js-relative-date" datetime="2011-03-29T20:46:37-07:00" title="2011-03-29 20:46:37">March 29, 2011</time>
#
#    </div>
#  </div>
#</div>
#
#
#<!-- block_view_fragment_key: views4/v8/blob:v17:75e4d0e38c95ac034d5ef175a9b0f142 -->
#  <div id="slider">
#
#    <div class="breadcrumb" data-path="code/python/dict/dict.py/">
#      <b itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/panweizeng/home/tree/84bf3ec006f8bccb532eb70386a0b35c7544687c" class="js-rewrite-sha" itemprop="url"><span itemprop="title">home</span></a></b> / <span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/panweizeng/home/tree/84bf3ec006f8bccb532eb70386a0b35c7544687c/code" class="js-rewrite-sha" itemscope="url"><span itemprop="title">code</span></a></span> / <span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/panweizeng/home/tree/84bf3ec006f8bccb532eb70386a0b35c7544687c/code/python" class="js-rewrite-sha" itemscope="url"><span itemprop="title">python</span></a></span> / <span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/panweizeng/home/tree/84bf3ec006f8bccb532eb70386a0b35c7544687c/code/python/dict" class="js-rewrite-sha" itemscope="url"><span itemprop="title">dict</span></a></span> / <strong class="final-path">dict.py</strong> <span class="js-clippy clippy-button " data-clipboard-text="code/python/dict/dict.py" data-copied-hint="copied!" data-copy-hint="copy to clipboard"></span>
#    </div>
#
#
#
#    <div class="frames">
#      <div class="frame frame-center" data-path="code/python/dict/dict.py/" data-permalink-url="/panweizeng/home/blob/84bf3ec006f8bccb532eb70386a0b35c7544687c/code/python/dict/dict.py" data-title="code/python/dict/dict.py at master from panweizeng/home - GitHub" data-type="blob">
#
#        <div id="files" class="bubble">
#          <div class="file">
#            <div class="meta">
#              <div class="info">
#                <span class="icon"><img alt="Txt" height="16" src="https://a248.e.akamai.net/assets.github.com/images/icons/txt.png?1315867479" width="16" /></span>
#                <span class="mode" title="File Mode">100755</span>
#                  <span>44 lines (36 sloc)</span>
#                <span>1.379 kb</span>
#              </div>
#              <ul class="button-group actions">
#                  <li>
#                    <a class="grouped-button file-edit-link minibutton bigger lighter js-rewrite-sha" href="/panweizeng/home/edit/84bf3ec006f8bccb532eb70386a0b35c7544687c/code/python/dict/dict.py" data-method="post" rel="nofollow"><span>Edit this file</span></a>
#                  </li>
#
#                <li>
#                  <a href="/panweizeng/home/raw/master/code/python/dict/dict.py" class="minibutton btn-raw grouped-button bigger lighter" id="raw-url"><span><span class="icon"></span>Raw</span></a>
#                </li>
#                  <li>
#                    <a href="/panweizeng/home/blame/master/code/python/dict/dict.py" class="minibutton btn-blame grouped-button bigger lighter"><span><span class="icon"></span>Blame</span></a>
#                  </li>
#                <li>
#                  <a href="/panweizeng/home/commits/master/code/python/dict/dict.py" class="minibutton btn-history grouped-button bigger lighter" rel="nofollow"><span><span class="icon"></span>History</span></a>
#                </li>
#              </ul>
#            </div>
#              <div class="data type-python">
#      <table cellpadding="0" cellspacing="0" class="lines">
#        <tr>
#          <td>
#            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
#<span id="L2" rel="#L2">2</span>
#<span id="L3" rel="#L3">3</span>
#<span id="L4" rel="#L4">4</span>
#<span id="L5" rel="#L5">5</span>
#<span id="L6" rel="#L6">6</span>
#<span id="L7" rel="#L7">7</span>
#<span id="L8" rel="#L8">8</span>
#<span id="L9" rel="#L9">9</span>
#<span id="L10" rel="#L10">10</span>
#<span id="L11" rel="#L11">11</span>
#<span id="L12" rel="#L12">12</span>
#<span id="L13" rel="#L13">13</span>
#<span id="L14" rel="#L14">14</span>
#<span id="L15" rel="#L15">15</span>
#<span id="L16" rel="#L16">16</span>
#<span id="L17" rel="#L17">17</span>
#<span id="L18" rel="#L18">18</span>
#<span id="L19" rel="#L19">19</span>
#<span id="L20" rel="#L20">20</span>
#<span id="L21" rel="#L21">21</span>
#<span id="L22" rel="#L22">22</span>
#<span id="L23" rel="#L23">23</span>
#<span id="L24" rel="#L24">24</span>
#<span id="L25" rel="#L25">25</span>
#<span id="L26" rel="#L26">26</span>
#<span id="L27" rel="#L27">27</span>
#<span id="L28" rel="#L28">28</span>
#<span id="L29" rel="#L29">29</span>
#<span id="L30" rel="#L30">30</span>
#<span id="L31" rel="#L31">31</span>
#<span id="L32" rel="#L32">32</span>
#<span id="L33" rel="#L33">33</span>
#<span id="L34" rel="#L34">34</span>
#<span id="L35" rel="#L35">35</span>
#<span id="L36" rel="#L36">36</span>
#<span id="L37" rel="#L37">37</span>
#<span id="L38" rel="#L38">38</span>
#<span id="L39" rel="#L39">39</span>
#<span id="L40" rel="#L40">40</span>
#<span id="L41" rel="#L41">41</span>
#<span id="L42" rel="#L42">42</span>
#<span id="L43" rel="#L43">43</span>
#</pre>
#          </td>
#          <td width="100%">
#                <div class="highlight"><pre><div class='line' id='LC1'><span class="c">#!/usr/bin/python</span></div><div class='line' id='LC2'><span class="c">#coding=utf8</span></div><div class='line' id='LC3'><span class="kn">import</span> <span class="nn">urllib</span></div><div class='line' id='LC4'><span class="kn">import</span> <span class="nn">sys</span></div><div class='line' id='LC5'><span class="kn">import</span> <span class="nn">re</span></div><div class='line' id='LC6'><span class="kn">import</span> <span class="nn">xml.dom.minidom</span> <span class="kn">as</span> <span class="nn">xml</span></div><div class='line' id='LC7'><br/></div><div class='line' id='LC8'><span class="c">#API_URL = &#39;http://dict.cn/ws.php?utf8=true&amp;q=%s&#39;</span></div><div class='line' id='LC9'><span class="n">API_URL</span> <span class="o">=</span> <span class="s">&#39;http://dict-co.iciba.com/api/dictionary.php?w=</span><span class="si">%s</span><span class="s">&#39;</span></div><div class='line' id='LC10'><span class="k">def</span> <span class="nf">getword</span><span class="p">(</span><span class="n">word</span><span class="p">):</span></div><div class='line' id='LC11'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">xmls</span> <span class="o">=</span> <span class="n">urllib</span><span class="o">.</span><span class="n">urlopen</span><span class="p">(</span><span class="n">API_URL</span><span class="o">%</span><span class="n">urllib</span><span class="o">.</span><span class="n">quote</span><span class="p">(</span><span class="n">word</span><span class="p">))</span><span class="o">.</span><span class="n">read</span><span class="p">()</span></div><div class='line' id='LC12'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c">#print xmls</span></div><div class='line' id='LC13'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">root</span> <span class="o">=</span> <span class="n">xml</span><span class="o">.</span><span class="n">parseString</span><span class="p">(</span><span class="n">xmls</span><span class="p">)</span><span class="o">.</span><span class="n">documentElement</span></div><div class='line' id='LC14'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c">#print re.sub(u&#39;&gt;&#39;, &#39;&gt;\n&#39;,xmls)</span></div><div class='line' id='LC15'><br/></div><div class='line' id='LC16'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c">#tags = {&#39;key&#39;:&#39;单词&#39;, &#39;pron&#39;:&#39;音标&#39;, &#39;def&#39;:&#39;释义&#39;, &#39;sent&#39;:&#39;例句&#39;, &#39;orig&#39;:&#39;例句&#39;, &#39;trans&#39;:&#39;翻译&#39;, &#39;acceptation&#39;:&#39;释义&#39;}</span></div><div class='line' id='LC17'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">tags</span> <span class="o">=</span> <span class="p">{</span><span class="s">&#39;key&#39;</span><span class="p">:</span><span class="s">&#39;单词&#39;</span><span class="p">,</span> <span class="s">&#39;ps&#39;</span><span class="p">:</span><span class="s">&#39;音标&#39;</span><span class="p">,</span> <span class="s">&#39;def&#39;</span><span class="p">:</span><span class="s">&#39;释义&#39;</span><span class="p">,</span> <span class="s">&#39;sent&#39;</span><span class="p">:</span><span class="s">&#39;例句&#39;</span><span class="p">,</span> <span class="s">&#39;orig&#39;</span><span class="p">:</span><span class="s">&#39;例句&#39;</span><span class="p">,</span> <span class="s">&#39;trans&#39;</span><span class="p">:</span><span class="s">&#39;翻译&#39;</span><span class="p">,</span> <span class="s">&#39;acceptation&#39;</span><span class="p">:</span><span class="s">&#39;释义&#39;</span><span class="p">}</span></div><div class='line' id='LC18'><br/></div><div class='line' id='LC19'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">isElement</span><span class="p">(</span><span class="n">node</span><span class="p">):</span></div><div class='line' id='LC20'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="n">node</span><span class="o">.</span><span class="n">nodeType</span> <span class="o">==</span> <span class="n">node</span><span class="o">.</span><span class="n">ELEMENT_NODE</span></div><div class='line' id='LC21'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">isText</span><span class="p">(</span><span class="n">node</span><span class="p">):</span></div><div class='line' id='LC22'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="n">node</span><span class="o">.</span><span class="n">nodeType</span> <span class="o">==</span> <span class="n">node</span><span class="o">.</span><span class="n">TEXT_NODE</span></div><div class='line' id='LC23'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">show</span><span class="p">(</span><span class="n">node</span><span class="p">,</span> <span class="n">tagName</span><span class="o">=</span><span class="bp">None</span><span class="p">):</span></div><div class='line' id='LC24'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="n">isText</span><span class="p">(</span><span class="n">node</span><span class="p">):</span></div><div class='line' id='LC25'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">tag</span> <span class="o">=</span> <span class="n">tags</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="n">tagName</span><span class="p">,</span> <span class="n">tagName</span><span class="p">)</span></div><div class='line' id='LC26'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">print</span> <span class="s">&#39;</span><span class="si">%s</span><span class="s">:</span><span class="si">%s</span><span class="s">&#39;</span><span class="o">%</span><span class="p">(</span><span class="n">tag</span><span class="p">,</span> <span class="n">node</span><span class="o">.</span><span class="n">nodeValue</span><span class="p">)</span></div><div class='line' id='LC27'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">elif</span> <span class="n">isElement</span><span class="p">(</span><span class="n">node</span><span class="p">)</span> <span class="ow">and</span> <span class="n">tags</span><span class="o">.</span><span class="n">has_key</span><span class="p">(</span><span class="n">node</span><span class="o">.</span><span class="n">tagName</span><span class="p">):</span></div><div class='line' id='LC28'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">[</span><span class="n">show</span><span class="p">(</span><span class="n">i</span><span class="p">,</span> <span class="n">node</span><span class="o">.</span><span class="n">tagName</span><span class="p">)</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">node</span><span class="o">.</span><span class="n">childNodes</span><span class="p">]</span></div><div class='line' id='LC29'><br/></div><div class='line' id='LC30'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">[</span> <span class="n">show</span><span class="p">(</span><span class="n">i</span><span class="p">)</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">root</span><span class="o">.</span><span class="n">childNodes</span> <span class="k">if</span> <span class="n">isElement</span><span class="p">(</span><span class="n">i</span><span class="p">)</span> <span class="p">]</span></div><div class='line' id='LC31'>&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='line' id='LC32'><span class="k">def</span> <span class="nf">main</span><span class="p">():</span></div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nb">len</span><span class="p">(</span><span class="n">sys</span><span class="o">.</span><span class="n">argv</span><span class="p">)</span> <span class="o">&gt;=</span> <span class="mi">2</span><span class="p">:</span></div><div class='line' id='LC34'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">word</span> <span class="o">=</span> <span class="s">&#39; &#39;</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">sys</span><span class="o">.</span><span class="n">argv</span><span class="p">[</span><span class="mi">1</span><span class="p">:])</span></div><div class='line' id='LC35'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">getword</span><span class="p">(</span><span class="n">word</span><span class="p">)</span></div><div class='line' id='LC36'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">else</span><span class="p">:</span></div><div class='line' id='LC37'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">print</span> <span class="s">&#39;usage:dict [word]&#39;</span></div><div class='line' id='LC38'><br/></div><div class='line' id='LC39'><br/></div><div class='line' id='LC40'><span class="k">if</span> <span class="n">__name__</span> <span class="o">==</span> <span class="s">&#39;__main__&#39;</span><span class="p">:</span></div><div class='line' id='LC41'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nb">reload</span><span class="p">(</span><span class="n">sys</span><span class="p">)</span></div><div class='line' id='LC42'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">sys</span><span class="o">.</span><span class="n">setdefaultencoding</span><span class="p">(</span><span class="s">&#39;utf8&#39;</span><span class="p">)</span></div><div class='line' id='LC43'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">main</span><span class="p">()</span></div></pre></div>
#          </td>
#        </tr>
#      </table>
#  </div>
#
#          </div>
#        </div>
#      </div>
#    </div>
#
#  </div>
#
#<div class="frame frame-loading large-loading-area" style="display:none;" data-tree-list-url="/panweizeng/home/tree-list/84bf3ec006f8bccb532eb70386a0b35c7544687c" data-blob-url-prefix="/panweizeng/home/blob/84bf3ec006f8bccb532eb70386a0b35c7544687c">
#  <img src="https://a248.e.akamai.net/assets.github.com/images/spinners/octocat-spinner-64.gif?1329872007" height="64" width="64">
#</div>
#
#      </div>
#      <div class="context-overlay"></div>
#    </div>
#
#
#      <!-- footer -->
#      <div id="footer" >
#        
#  <div class="upper_footer">
#     <div class="container clearfix">
#
#       <!--[if IE]><h4 id="blacktocat_ie">GitHub Links</h4><![endif]-->
#       <![if !IE]><h4 id="blacktocat">GitHub Links</h4><![endif]>
#
#       <ul class="footer_nav">
#         <h4>GitHub</h4>
#         <li><a href="https://github.com/about">About</a></li>
#         <li><a href="https://github.com/blog">Blog</a></li>
#         <li><a href="https://github.com/features">Features</a></li>
#         <li><a href="https://github.com/contact">Contact &amp; Support</a></li>
#         <li><a href="https://github.com/training">Training</a></li>
#         <li><a href="http://enterprise.github.com/">GitHub Enterprise</a></li>
#         <li><a href="http://status.github.com/">Site Status</a></li>
#       </ul>
#
#       <ul class="footer_nav">
#         <h4>Tools</h4>
#         <li><a href="http://get.gaug.es/">Gauges: Analyze web traffic</a></li>
#         <li><a href="http://speakerdeck.com">Speaker Deck: Presentations</a></li>
#         <li><a href="https://gist.github.com">Gist: Code snippets</a></li>
#         <li><a href="http://mac.github.com/">GitHub for Mac</a></li>
#         <li><a href="http://mobile.github.com/">Issues for iPhone</a></li>
#         <li><a href="http://jobs.github.com/">Job Board</a></li>
#       </ul>
#
#       <ul class="footer_nav">
#         <h4>Extras</h4>
#         <li><a href="http://shop.github.com/">GitHub Shop</a></li>
#         <li><a href="http://octodex.github.com/">The Octodex</a></li>
#       </ul>
#
#       <ul class="footer_nav">
#         <h4>Documentation</h4>
#         <li><a href="http://help.github.com/">GitHub Help</a></li>
#         <li><a href="http://developer.github.com/">Developer API</a></li>
#         <li><a href="http://github.github.com/github-flavored-markdown/">GitHub Flavored Markdown</a></li>
#         <li><a href="http://pages.github.com/">GitHub Pages</a></li>
#       </ul>
#
#     </div><!-- /.site -->
#  </div><!-- /.upper_footer -->
#
#<div class="lower_footer">
#  <div class="container clearfix">
#    <!--[if IE]><div id="legal_ie"><![endif]-->
#    <![if !IE]><div id="legal"><![endif]>
#      <ul>
#          <li><a href="https://github.com/site/terms">Terms of Service</a></li>
#          <li><a href="https://github.com/site/privacy">Privacy</a></li>
#          <li><a href="https://github.com/security">Security</a></li>
#      </ul>
#
#      <p>&copy; 2012 <span title="0.04863s from fe9.rs.github.com">GitHub</span> Inc. All rights reserved.</p>
#    </div><!-- /#legal or /#legal_ie-->
#
#      <div class="sponsor">
#        <a href="http://www.rackspace.com" class="logo">
#          <img alt="Dedicated Server" height="36" src="https://a248.e.akamai.net/assets.github.com/images/modules/footer/rackspaces_logo.png?1329521039" width="38" />
#        </a>
#        Powered by the <a href="http://www.rackspace.com ">Dedicated
#        Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
#        Computing</a> of Rackspace Hosting<span>&reg;</span>
#      </div>
#  </div><!-- /.site -->
#</div><!-- /.lower_footer -->
#
#      </div><!-- /#footer -->
#
#    
#
#<div id="keyboard_shortcuts_pane" class="instapaper_ignore readability-extra" style="display:none">
#  <h2>Keyboard Shortcuts <small><a href="#" class="js-see-all-keyboard-shortcuts">(see all)</a></small></h2>
#
#  <div class="columns threecols">
#    <div class="column first">
#      <h3>Site wide shortcuts</h3>
#      <dl class="keyboard-mappings">
#        <dt>s</dt>
#        <dd>Focus site search</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>?</dt>
#        <dd>Bring up this help dialog</dd>
#      </dl>
#    </div><!-- /.column.first -->
#
#    <div class="column middle" style='display:none'>
#      <h3>Commit list</h3>
#      <dl class="keyboard-mappings">
#        <dt>j</dt>
#        <dd>Move selection down</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>k</dt>
#        <dd>Move selection up</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>c <em>or</em> o <em>or</em> enter</dt>
#        <dd>Open commit</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>y</dt>
#        <dd>Expand URL to its canonical form</dd>
#      </dl>
#    </div><!-- /.column.first -->
#
#    <div class="column last" style='display:none'>
#      <h3>Pull request list</h3>
#      <dl class="keyboard-mappings">
#        <dt>j</dt>
#        <dd>Move selection down</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>k</dt>
#        <dd>Move selection up</dd>
#      </dl>
#      <dl class="keyboard-mappings">
#        <dt>o <em>or</em> enter</dt>
#        <dd>Open issue</dd>
#      </dl>
#    </div><!-- /.columns.last -->
#
#  </div><!-- /.columns.equacols -->
#
#  <div style='display:none'>
#    <div class="rule"></div>
#
#    <h3>Issues</h3>
#
#    <div class="columns threecols">
#      <div class="column first">
#        <dl class="keyboard-mappings">
#          <dt>j</dt>
#          <dd>Move selection down</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>k</dt>
#          <dd>Move selection up</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>x</dt>
#          <dd>Toggle selection</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>o <em>or</em> enter</dt>
#          <dd>Open issue</dd>
#        </dl>
#      </div><!-- /.column.first -->
#      <div class="column middle">
#        <dl class="keyboard-mappings">
#          <dt>I</dt>
#          <dd>Mark selection as read</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>U</dt>
#          <dd>Mark selection as unread</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>e</dt>
#          <dd>Close selection</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>y</dt>
#          <dd>Remove selection from view</dd>
#        </dl>
#      </div><!-- /.column.middle -->
#      <div class="column last">
#        <dl class="keyboard-mappings">
#          <dt>c</dt>
#          <dd>Create issue</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>l</dt>
#          <dd>Create label</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>i</dt>
#          <dd>Back to inbox</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>u</dt>
#          <dd>Back to issues</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>/</dt>
#          <dd>Focus issues search</dd>
#        </dl>
#      </div>
#    </div>
#  </div>
#
#  <div style='display:none'>
#    <div class="rule"></div>
#
#    <h3>Issues Dashboard</h3>
#
#    <div class="columns threecols">
#      <div class="column first">
#        <dl class="keyboard-mappings">
#          <dt>j</dt>
#          <dd>Move selection down</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>k</dt>
#          <dd>Move selection up</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>o <em>or</em> enter</dt>
#          <dd>Open issue</dd>
#        </dl>
#      </div><!-- /.column.first -->
#    </div>
#  </div>
#
#  <div style='display:none'>
#    <div class="rule"></div>
#
#    <h3>Network Graph</h3>
#    <div class="columns equacols">
#      <div class="column first">
#        <dl class="keyboard-mappings">
#          <dt><span class="badmono">←</span> <em>or</em> h</dt>
#          <dd>Scroll left</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt><span class="badmono">→</span> <em>or</em> l</dt>
#          <dd>Scroll right</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt><span class="badmono">↑</span> <em>or</em> k</dt>
#          <dd>Scroll up</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt><span class="badmono">↓</span> <em>or</em> j</dt>
#          <dd>Scroll down</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>t</dt>
#          <dd>Toggle visibility of head labels</dd>
#        </dl>
#      </div><!-- /.column.first -->
#      <div class="column last">
#        <dl class="keyboard-mappings">
#          <dt>shift <span class="badmono">←</span> <em>or</em> shift h</dt>
#          <dd>Scroll all the way left</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>shift <span class="badmono">→</span> <em>or</em> shift l</dt>
#          <dd>Scroll all the way right</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>shift <span class="badmono">↑</span> <em>or</em> shift k</dt>
#          <dd>Scroll all the way up</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>shift <span class="badmono">↓</span> <em>or</em> shift j</dt>
#          <dd>Scroll all the way down</dd>
#        </dl>
#      </div><!-- /.column.last -->
#    </div>
#  </div>
#
#  <div >
#    <div class="rule"></div>
#    <div class="columns threecols">
#      <div class="column first" >
#        <h3>Source Code Browsing</h3>
#        <dl class="keyboard-mappings">
#          <dt>t</dt>
#          <dd>Activates the file finder</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>l</dt>
#          <dd>Jump to line</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>w</dt>
#          <dd>Switch branch/tag</dd>
#        </dl>
#        <dl class="keyboard-mappings">
#          <dt>y</dt>
#          <dd>Expand URL to its canonical form</dd>
#        </dl>
#      </div>
#    </div>
#  </div>
#</div>
#
#    <div id="markdown-help" class="instapaper_ignore readability-extra">
#  <h2>Markdown Cheat Sheet</h2>
#
#  <div class="cheatsheet-content">
#
#  <div class="mod">
#    <div class="col">
#      <h3>Format Text</h3>
#      <p>Headers</p>
#      <pre>
## This is an &lt;h1&gt; tag
### This is an &lt;h2&gt; tag
####### This is an &lt;h6&gt; tag</pre>
#     <p>Text styles</p>
#     <pre>
#*This text will be italic*
#_This will also be italic_
#**This text will be bold**
#__This will also be bold__
#
#*You **can** combine them*
#</pre>
#    </div>
#    <div class="col">
#      <h3>Lists</h3>
#      <p>Unordered</p>
#      <pre>
#* Item 1
#* Item 2
#  * Item 2a
#  * Item 2b</pre>
#     <p>Ordered</p>
#     <pre>
#1. Item 1
#2. Item 2
#3. Item 3
#   * Item 3a
#   * Item 3b</pre>
#    </div>
#    <div class="col">
#      <h3>Miscellaneous</h3>
#      <p>Images</p>
#      <pre>
#![GitHub Logo](/images/logo.png)
#Format: ![Alt Text](url)
#</pre>
#     <p>Links</p>
#     <pre>
#http://github.com - automatic!
#[GitHub](http://github.com)</pre>
#<p>Blockquotes</p>
#     <pre>
#As Kanye West said:
#
#> We're living the future so
#> the present is our past.
#</pre>
#    </div>
#  </div>
#  <div class="rule"></div>
#
#  <h3>Code Examples in Markdown</h3>
#  <div class="col">
#      <p>Syntax highlighting with <a href="http://github.github.com/github-flavored-markdown/" title="GitHub Flavored Markdown" target="_blank">GFM</a></p>
#      <pre>
#```javascript
#function fancyAlert(arg) {
#  if(arg) {
#    $.facebox({div:'#foo'})
#  }
#}
#```</pre>
#    </div>
#    <div class="col">
#      <p>Or, indent your code 4 spaces</p>
#      <pre>
#Here is a Python code example
#without syntax highlighting:
#
#    def foo:
#      if not bar:
#        return true</pre>
#    </div>
#    <div class="col">
#      <p>Inline code for comments</p>
#      <pre>
#I think you should use an
#`&lt;addr&gt;` element here instead.</pre>
#    </div>
#  </div>
#
#  </div>
#</div>
#
#
#    <div class="ajax-error-message">
#      <p><span class="icon"></span> Something went wrong with that request. Please try again. <a href="javascript:;" class="ajax-error-dismiss">Dismiss</a></p>
#    </div>
#
#    
#    
#    
#    <span id='server_response_time' data-time='0.05009' data-host='fe9'></span>
#  </body>
#</html>
#
