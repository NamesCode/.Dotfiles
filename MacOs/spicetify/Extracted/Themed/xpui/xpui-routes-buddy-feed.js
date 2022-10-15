"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[4338],{83501:(e,n,i)=>{i.r(n),i.d(n,{default:()=>fi});var t=i(4942),r=i(29439),a=(i(91058),i(67294)),s=i(94184),l=i.n(s),c=i(32667),o=i(47647),d=i(74410),u=i(74257),f=i(46802),m=i(96206),v=i(23701),h=i(37415),x=i(92823),g=i(47291),b=i(51674),p=i(8716),j=i(32648),y=i(5229),N=i(15852),k=i(50054),C=(i(24812),i(42441)),E=i.n(C),D=i(88842),I=i(31638);const S="72px",w="230px",_="160px",A="270px",F="270px",L="384px";var O,U=i(85893),B=parseInt(S,10),T=parseInt(A,10),z=parseInt(w,10),P=parseInt(L,10),Z=parseInt(_,10),R=function(e){var n=e.size,i=e.setSize,t=e.elementRef,r=e.isBuddyFeedEmpty,s=e.showAddFriends;(0,a.useEffect)((function(){return E().bind(D.lb.BUDDY_FEED_DECREASE_WIDTH,(function(){n&&i(n-10)})),E().bind(D.lb.BUDDY_FEED_INCREASE_WIDTH,(function(){n&&i(n+10)})),function(){E().unbind(D.lb.BUDDY_FEED_DECREASE_WIDTH),E().unbind(D.lb.BUDDY_FEED_INCREASE_WIDTH)}}),[i,n]);var l=!r&&!s,c=l?B:T;return(0,U.jsx)(I.A,{elementRef:t,placement:"inline-start",label:m.ag.get("resize.sidebar"),cssCustomProperty:"--buddy-feed-width",onCSSPropertyChange:function(e){i(e)},initialValue:n,min:c,minExpanded:l?z:c,max:P,thresholdCollapsed:Z},c)},M=i(98197),Y=i(34011),H=i(35032),W=i(14134),q=i(73012),J=i(22867);!function(e){e[e.LOADING=0]="LOADING",e[e.CONNECTED=1]="CONNECTED",e[e.DISCONNECTED=2]="DISCONNECTED"}(O||(O={}));i(57327),i(41539);var K=i(24697),G=i(44295),Q=i(22247),V=i(15861),X=i(87757),$=i.n(X),ee=(i(73210),i(2707),i(82772),i(88767)),ne=(i(21249),i(68309),i(26699),i(32023),i(91552)),ie=i(22647),te=i(50266),re=i(1646);const ae="w5nHQ74JGTytKwWanjvB",se="u11kJflcqt7CSXo9qL_T",le="MmENkh6tW0MyjTtTtPHZ",ce="Gl0dkNQbAyNjVZ1IpghI";var oe=function(e){var n=e.name,i=e.following,t=e.imageUrl,s=e.uri,u=(0,te.q)(),f=(0,x.o)(),v=a.createRef(),h=(0,a.useState)(i),g=(0,r.Z)(h,2),b=g[0],j=g[1];(0,re.d)(ie.rA.OPERATION_COMPLETE,(function(e){if(e.data.uris.includes(s))switch(e.data.operation){case ie.BM.FOLLOW_USER:j(!0);break;case ie.BM.UNFOLLOW_USER:j(!1)}}));var y=(0,a.useCallback)((function(){b?u.unfollowUsers([s]):(u.followUsers([s]),f({intent:"follow",type:"click",itemIdSuffix:"buddyfeed"})),v.current&&v.current.blur()}),[b,v,s,u,f]);return(0,U.jsxs)("div",{className:ae,children:[(0,U.jsx)(ne.q,{label:n,width:40,userIconSize:16,images:(0,a.useMemo)((function(){return[{width:40,height:40,url:t}]}),[t])}),(0,U.jsxs)("div",{className:l()(se,"ellipsis-one-line"),children:[(0,U.jsx)(c.D,{as:"p",variant:"mestoBold",className:"ellipsis-one-line",children:n}),b&&(0,U.jsx)(c.D,{as:"p",variant:"finale",className:"ellipsis-one-line",children:m.ag.get("following")})]}),(0,U.jsx)("div",{className:le,children:(0,U.jsx)(p.E,{className:ce,size:"sm",ref:v,onClick:y,ariaLabel:b?m.ag.get("buddy-feed.button.remove-friend"):m.ag.get("buddy-feed.button.add-friend"),icon:b?d.k:o.t})})]})};const de="nGInMrf62TCFD9MBnEzz";function ue(e){var n=e.facebookFriends;return(0,U.jsx)("div",{className:de,children:n.map((function(e){var n=e.uri,i=e.following,t=e.title,r=e.image;return(0,U.jsx)(oe,{uri:n,name:t,imageUrl:r,following:i},"fb-friend-".concat(n))}))})}i(43290);const fe="n6rSk6R7nfmSGSgTRR5_";function me(){return(0,U.jsx)("div",{className:fe,children:Array(20).fill(0).map((function(e,n){return(0,U.jsx)(Q.C,{isLoading:!0,charCount:100,as:"p",variant:"canon"},n)}))})}const ve="pZFwflwH1vXVCmAO5vbz",he="yPL55nV5rC97vJhAf7ke",xe="qpgo9DQ9rVZbO5pLJog5",ge="A3hvkJOGkBNa6zWj6oZa",be="pIyez6N1SF3jW0U5VUx4",pe="lIxuZR4lYTrEKkMYedty",je="VEmC3OHK3uAasHvO5OuA",ye="wzGPtuvvLpOpY1PDu4Qv",Ne="YoJTUV4hazVCFNbfKoNq";var ke=function(e){var n,i,t,s,l,o,d=e.onBackButtonClick,u=(0,a.useState)(""),f=(0,r.Z)(u,2),v=f[0],h=f[1],x=(n=v,t=(0,J.I)(),s=n.trim().toLowerCase(),l=(0,ee.useQuery)("useFacebookFriends",(0,V.Z)($().mark((function e(){var n;return $().wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,t.fetchFacebookFriends();case 2:return n=e.sent,e.abrupt("return",n.sort((function(e,n){return e.title>n.title?1:-1})));case 4:case"end":return e.stop()}}),e)})))),o=l.data,{isLoading:l.isLoading,friends:null!==(i=null==o?void 0:o.filter((function(e){return-1!==e.title.trim().toLowerCase().indexOf(s)})))&&void 0!==i?i:[]}),g=x.isLoading,b=x.friends,j=(0,K.y1)((function(e){h(e.target.value)}),100),y=(0,a.useCallback)((function(e){null!==e&&e.focus()}),[]);return(0,U.jsxs)("div",{className:ve,children:[(0,U.jsx)(p.E,{ariaLabel:m.ag.get("buddy-feed.button.back"),onClick:d,ref:y,className:he,icon:M.e,size:"sm",testId:"back-to-friends"}),(0,U.jsxs)("div",{className:xe,children:[(0,U.jsx)("div",{className:ge,children:(0,U.jsx)(H.z,{className:be,iconSize:32})}),(0,U.jsx)("div",{className:pe,children:g?(0,U.jsx)(Q.C,{isLoading:!0,charCount:25,as:"p",variant:"mesto"}):(0,U.jsx)(c.D,{as:"p",variant:"mesto",children:m.ag.get("buddy-feed.number-of-friends",b.length)})})]}),g?(0,U.jsx)(me,{}):(0,U.jsxs)(U.Fragment,{children:[(0,U.jsxs)("div",{className:je,children:[(0,U.jsx)(G.j,{className:Ne,iconSize:16,role:"presentation"}),(0,U.jsx)("input",{onChange:j,className:ye,placeholder:m.ag.get("buddy-feed.find-in-playlists")})]}),(0,U.jsx)(ue,{facebookFriends:b})]})]})};const Ce="EmZCbU1_B_J9RAHebolL",Ee="Ym6Yyx83U7mNKOMw9dxw",De="NXcZaSipzomJ6d4_nM94",Ie="b9rqRkvRvhrSY4FYHQVC",Se="xHc_2FQr3NxfCgfDSVhY",we="QAJYN0xWh3h2A5d8_C1g",_e="PKhH1CknobkjJdVITsb4",Ae="HgRmCE3NxfiYNtv6pF3H",Fe="HnA5mipUMkheAlbxqCn_",Le="mvp0xhvZTo0xv0TIwi9u";var Oe=function(e){var n=(0,x.o)(),i=e.onBackButtonClick,t=e.feedIsEmpty,s=e.goToAddFriends,l=void 0!==s&&s,o=function(){var e=(0,J.I)(),n=(0,a.useState)(O.LOADING),i=(0,r.Z)(n,2),t=i[0],s=i[1];return(0,a.useEffect)((function(){return e.subscribeToFacebookConnectionState((function(e){s(e.connection?O.CONNECTED:O.DISCONNECTED)})).cancel}),[e]),t}(),d=(0,J.I)(),u=(0,a.useState)(!1),f=(0,r.Z)(u,2),v=f[0],h=f[1],g=(0,a.useState)(!1),b=(0,r.Z)(g,2),j=b[0],y=b[1],N=(0,a.useCallback)((function(e){null!==e&&e.focus()}),[]);if(v)return(0,U.jsxs)("div",{className:Fe,children:[(0,U.jsx)(p.E,{onClick:i,ref:N,className:De,ariaLabel:m.ag.get("buddy-feed.button.back"),icon:M.e,size:"sm"}),(0,U.jsxs)("div",{className:Le,children:[(0,U.jsx)(c.D,{as:"h1",variant:"balladBold",className:Ee,children:m.ag.get("error-dialog.generic.header")}),(0,U.jsx)(c.D,{as:"p",variant:"mesto",className:Ie,children:m.ag.get("error-dialog.generic.body")}),(0,U.jsx)(Y.D,{colorSet:"invertedLight",onClick:location.reload,children:m.ag.get("error.reload")})]})]});var k=(l||j)&&o===O.CONNECTED;return(0,U.jsxs)("div",{className:Ce,children:[k&&(0,U.jsx)(ke,{onBackButtonClick:function(){t&&y(!1),i()}}),!k&&(0,U.jsxs)("div",{className:we,children:[(0,U.jsx)(p.E,{ariaLabel:m.ag.get("buddy-feed.button.back"),onClick:i,className:De,ref:N,icon:M.e,size:"sm"}),(0,U.jsx)(c.D,{as:"h1",variant:"balladBold",className:Ee,children:m.ag.get("buddy-feed.friend-activity")}),(0,U.jsx)(c.D,{as:"p",variant:"mesto",className:Ie,children:m.ag.get("buddy-feed.facebook.connect-with-friends-default")}),(0,U.jsx)("div",{className:_e,children:(0,U.jsx)(Y.D,{className:Ae,buttonSize:"sm",iconLeading:H.z,UNSAFE_colorSet:(0,W.Ev)("#2374E1",q.$_Y.white),onClick:function(){n({intent:"connect-to-facebook",type:"click",itemIdSuffix:"buddyfeed"}),o!==O.CONNECTED?d.connectToFacebook().then((function(){y(!0)})).catch((function(){h(!0)})):y(!0)},children:m.ag.get("buddy-feed.facebook.button")})}),(0,U.jsx)(c.D,{as:"p",variant:"finale",className:Se,children:m.ag.get("buddy-feed.facebook.disclaimer")})]})]})},Ue=i(73727),Be=i(38370);const Te="main-buddyFeed-buddyFeedRoot",ze="main-buddyFeed-buddyFeed",Pe="main-buddyFeed-header",Ze="main-buddyFeed-username",Re="main-buddyFeed-headerTitle",Me="main-buddyFeed-scrollableArea",Ye="main-buddyFeed-friendActivity",He="qgeL6mhrwhk2RldoRar8",We="SQHCRmgNjRywo1Lt7rP3",qe="SCwzmMSXoZsmhGtGX81s",Je="VLKqDIGaQn2bILzJKSZ0",Ke="main-buddyFeed-friendsFeedContainer",Ge="main-buddyFeed-avatarContainer",Qe="main-buddyFeed-overlay",Ve="Irsd58UNEmDPxdhXKXCs",Xe="main-buddyFeed-activityMetadata",$e="main-buddyFeed-usernameAndTimestamp",en="main-buddyFeed-timestamp",nn="main-buddyFeed-artistAndTrackName",tn="main-buddyFeed-playbackContextIcon",rn="main-buddyFeed-playbackContext",an="main-buddyFeed-playbackContextLink",sn="main-buddyFeed-findFriendsButton",ln="main-buddyFeed-addFriendPlaceholder",cn="QXcmb_46WM1geLhhkcdq",on="main-buddyFeed-addFriendPlaceholderBtn",dn="MObmOrMxbQpO10ebAtZA",un="cBPbfBWIIPDzhIT6i3ih",fn="PjDcsgAPmXlcTBJRGpIu",mn="IRpPQFA57qgQ5jicWWaD",vn="Hm3nIbegLclY1uCAmnx_",hn="bhRoVUHjWdo9mgUkU6fe",xn="BliqfY7vu_qE2C9zs5Ou",gn="qdYWuHZd4HdSWfd4pSQB",bn="DhvYWKjDc7uyF3HfkDJJ",pn="ralK8s_OmE8a8zWcfNKM";var jn=function(e){var n=e.showOnlineIndicator;return(0,U.jsxs)("div",{className:fn,children:[(0,U.jsxs)("div",{className:mn,children:[(0,U.jsx)(Be.f,{iconSize:24}),n?(0,U.jsx)("div",{className:vn}):null]}),(0,U.jsxs)("div",{className:hn,children:[(0,U.jsx)("div",{className:l()(xn,gn)}),(0,U.jsx)("div",{className:xn}),(0,U.jsx)("div",{className:xn})]})]})},yn=function(){return(0,U.jsxs)("div",{"data-testid":"buddy-feed-empty-state",className:dn,children:[(0,U.jsx)(c.D,{as:"p",className:un,children:m.ag.get("buddy-feed.let-followers-see-your-listening")}),(0,U.jsx)(jn,{showOnlineIndicator:!0}),(0,U.jsx)(jn,{showOnlineIndicator:!0}),(0,U.jsx)(jn,{}),(0,U.jsx)(c.D,{as:"p",className:un,children:m.ag.get("buddy-feed.enable-share-listening-activity")}),(0,U.jsx)(Ue.rU,{to:"/preferences",className:bn,children:(0,U.jsx)(Y.D,{colorSet:"invertedLight",className:pn,children:m.ag.get("desktop.settings.settings")})})]})},Nn=i(94537),kn=i(61075);const Cn="jUF2eKgYMm64aYykubct",En="zhL_lhJqzKfJVy7L5VuY",Dn="XqquM_o2eODcnD8Y4QhS",In="UGtycHBJ4egymBSmD_lX",Sn="ND2ydDPzwQZB7HyaGCN8",wn="D9YN554UFGJle2CPP1TA",_n="v7Zcy9UKVUTDZIMKB6ZF",An="RX3U6eAasqazEkuFdnj0";var Fn=function(e){var n=e.children,i=e.page,t=0===i,r=n.filter((function(e,n){return n!==i}));return(0,U.jsx)(Nn.Z,{component:null,children:r.map((function(e){return(0,U.jsx)(kn.Z,{in:t,timeout:500,classNames:{enter:t?Cn:Sn,enterActive:t?En:wn,exit:t?Dn:_n,exitActive:t?In:An},children:e},t?"first-page":"second-page")}))})},Ln=(i(47042),i(91038),i(74916),i(77601),i(82526),i(41817),i(32165),i(79753),i(21703),i(96647),i(78783),i(66992),i(33948),i(69826),i(93433));i(5212),i(92222);function On(e){return e.sort((function(e,n){return n.timestamp-e.timestamp}))}function Un(e,n){return n.some((function(n){return n.user.uri===e.user.uri}))?n:On([].concat((0,Ln.Z)(n),[e]))}function Bn(e,n){return n.filter((function(n){return n.user.uri!==e}))}i(85827),i(89554),i(54747),i(26833);var Tn=i(69518),zn=i.n(Tn);function Pn(e,n){var i="undefined"!=typeof Symbol&&e[Symbol.iterator]||e["@@iterator"];if(!i){if(Array.isArray(e)||(i=function(e,n){if(!e)return;if("string"==typeof e)return Zn(e,n);var i=Object.prototype.toString.call(e).slice(8,-1);"Object"===i&&e.constructor&&(i=e.constructor.name);if("Map"===i||"Set"===i)return Array.from(e);if("Arguments"===i||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(i))return Zn(e,n)}(e))||n&&e&&"number"==typeof e.length){i&&(e=i);var t=0,r=function(){};return{s:r,n:function(){return t>=e.length?{done:!0}:{done:!1,value:e[t++]}},e:function(e){throw e},f:r}}throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}var a,s=!0,l=!1;return{s:function(){i=i.call(e)},n:function(){var e=i.next();return s=e.done,e},e:function(e){l=!0,a=e},f:function(){try{s||null==i.return||i.return()}finally{if(l)throw a}}}}function Zn(e,n){(null==n||n>e.length)&&(n=e.length);for(var i=0,t=new Array(n);i<n;i++)t[i]=e[i];return t}function Rn(e){var n=(0,J.I)(),i=(0,a.useState)(On(e)),t=(0,r.Z)(i,2),s=t[0],l=t[1],c=function(e,n){var i=(0,J.I)(),t=(0,a.useRef)(e),r=(0,a.useRef)({}),s=(0,a.useRef)(n);s.current=n;var l=(0,a.useCallback)((function(e){var n,t=null===(n=zn().from(e))||void 0===n?void 0:n.username;return i.subscribeToBuddyActivity(t,(function(e){e&&s.current(e)}))}),[i]),c=(0,a.useCallback)((function(e){var n;null===(n=r.current[e])||void 0===n||n.cancel(),delete r.current[e]}),[]);return(0,a.useEffect)((function(){r.current=t.current.reduce((function(e,n){var i=n.user.uri,t=l(i);return e[i]=t,e}),{})}),[l]),(0,a.useEffect)((function(){var e=r.current;return function(){Object.values(e).forEach((function(e){e.cancel()}))}}),[]),{subscribeToFriend:l,unSubscribeFromFriend:c}}(e,(function(e){l((function(n){return function(e,n){return On(n.map((function(n){return n.user.uri===e.user.uri?e:n})))}(e,n)}))})),o=c.subscribeToFriend,d=c.unSubscribeFromFriend;return(0,re.d)(ie.rA.OPERATION_COMPLETE,function(){var e=(0,V.Z)($().mark((function e(i){var t,r,a,c,u,f,m;return $().wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(t=i.data.uris,i.data.operation!==ie.BM.FOLLOW_USER){e.next=19;break}r=Pn(t),e.prev=3,c=$().mark((function e(){var i,t,r;return $().wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(i=a.value,s.find((function(e){return e.user.uri===i}))){e.next=8;break}return e.next=4,n.fetchFriendActivity([i]);case 4:t=e.sent,r=t[0],l((function(e){return Un(r,e)})),o(i);case 8:case"end":return e.stop()}}),e)})),r.s();case 6:if((a=r.n()).done){e.next=10;break}return e.delegateYield(c(),"t0",8);case 8:e.next=6;break;case 10:e.next=15;break;case 12:e.prev=12,e.t1=e.catch(3),r.e(e.t1);case 15:return e.prev=15,r.f(),e.finish(15);case 18:return e.abrupt("return");case 19:if(i.data.operation===ie.BM.UNFOLLOW_USER){u=Pn(t);try{for(m=function(){var e=f.value;s.find((function(n){return n.user.uri===e}))&&(d(e),l((function(n){return Bn(e,n)})))},u.s();!(f=u.n()).done;)m()}catch(e){u.e(e)}finally{u.f()}}case 20:case"end":return e.stop()}}),e,null,[[3,12,15,18]])})));return function(n){return e.apply(this,arguments)}}()),s}i(69600);var Mn=i(12690),Yn=(i(3843),i(83710),i(4232)),Hn=i(80507),Wn=i(35410),qn=i(86514),Jn=i(88214),Kn=i(43480),Gn=i(67892),Qn=i(83813),Vn=i(57784),Xn=i(18261),$n=i(49343),ei=i(42922),ni=i(84242),ii=i(634),ti=i(83692),ri=(i(33161),i(9653),function(e){if(!Number.isInteger(e))return"";var n=Date.now()-Number(e),i=Math.round(n/1e3/60),t=Math.round(n/1e3/60/60),r=Math.round(n/1e3/60/60/24),a=Math.round(n/1e3/60/60/24/7);return r>=7?m.ag.get("time.weeks.short",a):t>=24?m.ag.get("time.days.short",r):i>=60?m.ag.get("time.hours.short",t):i>0?m.ag.get("time.minutes.short",i):m.ag.get("time.now")}),ai=function(e){var n=e.timestamp;return e.isNowPlaying?(0,U.jsx)(ti.w,{label:m.ag.get("time.now"),children:(0,U.jsx)(ii.h,{"aria-label":m.ag.get("time.now"),iconSize:16})}):(0,U.jsx)("span",{children:ri(n)})},si=function(e){return Date.now()-e<9e5},li=function(e,n){var i;switch(null===(i=zn().from(e))||void 0===i?void 0:i.type){case zn().Type.PLAYLIST:case zn().Type.PLAYLIST_V2:return(0,U.jsx)(Wn.X,{uri:e});case zn().Type.EPISODE:case zn().Type.SHOW:return(0,U.jsx)(qn.M,{uri:e});case zn().Type.ALBUM:return(0,U.jsx)(Yn.Y,{uri:e,artistUri:n});case zn().Type.ARTIST:return(0,U.jsx)(Hn.m,{uri:e});default:return null}},ci=function(e){var n,i,r,s,o,d,u,f,v,h,g,b,p,j,y,k,C,E,D,I=e.show,S=void 0===I||I,w=e.spec,_=e.friend,A=(0,a.useMemo)((function(){return _.user.imageUrl?[{url:_.user.imageUrl,width:0,height:0}]:[]}),[_.user.imageUrl]),F=(0,x.o)(),L=(0,N.$P)(),O=_.track,B=O.uri,T=null==O||null===(n=O.context)||void 0===n?void 0:n.uri,z=(0,(0,ni.n)({uri:T},{featureIdentifier:"buddy_feed",referrerIdentifier:"buddy_feed"}).usePlayContextItem)({uri:B}),P=z.togglePlay,Z=z.isPlaying,R=z.isActive,M=(0,a.useCallback)((function(){P(),F({intent:Z?"pause":"play",type:"click",itemIdSuffix:"buddyfeed_play",targetUri:B});var e=w.friendRowFactory().playButtonFactory();R?Z?L.logInteraction(e.hitPause({itemToBePaused:B})):L.logInteraction(e.hitResume({itemToBeResumed:B})):L.logInteraction(e.hitPlay({itemToBePlayed:B}))}),[P,F,Z,B,w,R,L]),Y=(0,a.useCallback)((function(e,n){L.logInteraction(w.friendRowFactory().friendRowLinkFactory({identifier:e}).hitUiNavigate({destination:n}))}),[L,w]),H=(0,Vn.O1)([B],O.name),W=(0,Vn.O1)([null===(i=O.artist)||void 0===i?void 0:i.uri],null===(r=O.artist)||void 0===r?void 0:r.name),q=(0,Vn.O1)([null===(s=O.context)||void 0===s?void 0:s.uri],null===(o=O.context)||void 0===o?void 0:o.name);return S?(0,U.jsxs)("div",{className:l()(Ye,(0,t.Z)({},He,e.isCollapsed)),children:[(0,U.jsx)(Xn._,{menu:li(null===(d=O.context)||void 0===d?void 0:d.uri,null===(u=O.artist)||void 0===u?void 0:u.uri),children:(0,U.jsxs)("div",{className:Ge,children:[(0,U.jsx)(ne.q,{label:_.user.name,width:40,userIconSize:16,images:A,withBadge:si(_.timestamp)}),(0,U.jsx)(Qn.I,{className:Qe,iconClassName:Ve,isPlaying:Z,isLocked:!1,onClick:M,playAriaLabel:Z?m.ag.get("pause"):"".concat(m.ag.get("play")," ").concat(O.artist.name," ").concat(O.name)})]})}),!e.isCollapsed&&(0,U.jsxs)("div",{className:l()(Xe),children:[(0,U.jsxs)("div",{className:$e,children:[(0,U.jsx)(c.D,{as:"p",variant:"mestoBold",className:l()(Ze,"ellipsis-one-line"),children:(0,U.jsx)(ei.ZP,{value:"/buddyfeed_user_profile",children:(0,U.jsx)(Xn._,{menu:(0,U.jsx)(Kn.I,{uri:_.user.uri}),children:(0,U.jsx)(Gn.r,{title:_.user.name,to:_.user.uri,dir:"auto",onClick:function(){return Y("profile_link",_.user.uri)},children:_.user.name})})})}),(0,U.jsx)(c.D,{as:"p",variant:"finale",className:l()(en),children:(0,U.jsx)(ai,{timestamp:_.timestamp,isNowPlaying:si(_.timestamp)})})]}),(0,U.jsxs)(c.D,{as:"p",variant:"finale",className:nn,children:[(0,U.jsx)(ei.ZP,{value:"/buddyfeed_track",children:(0,U.jsx)(Xn._,{menu:(0,U.jsx)(Jn.$,{uri:O.uri,contextUri:null===(f=O.context)||void 0===f?void 0:f.uri,albumUri:null===(v=O.album)||void 0===v?void 0:v.uri,artists:[O.artist]}),children:(0,U.jsx)(Gn.r,{title:O.name,to:B,className:"ellipsis-one-line",dir:"auto",draggable:!0,onDragStart:H,onClick:function(){return Y("track_link",B)},children:O.name})})}),(0,U.jsx)("span",{"aria-hidden":!0,children:" • "}),(0,U.jsx)(ei.ZP,{value:"/buddyfeed_artist",children:(0,U.jsx)(Xn._,{menu:O.artist?(0,U.jsx)(Hn.m,{uri:O.artist.uri}):null,children:(0,U.jsx)(Gn.r,{title:null===(h=O.artist)||void 0===h?void 0:h.name,to:null===(g=O.artist)||void 0===g?void 0:g.uri,className:"ellipsis-one-line",dir:"auto",draggable:!0,onDragStart:W,onClick:function(){var e;return Y("artist_link",null===(e=O.artist)||void 0===e?void 0:e.uri)},children:null===(b=O.artist)||void 0===b?void 0:b.name})})})]}),(0,U.jsx)(c.D,{as:"p",variant:"finale",className:l()("ellipsis-one-line",rn),children:(0,U.jsx)(ei.ZP,{value:"/buddyfeed_context",children:(0,U.jsx)(Xn._,{menu:li(null===(p=O.context)||void 0===p?void 0:p.uri,null===(j=O.artist)||void 0===j?void 0:j.uri),children:(0,U.jsxs)(Gn.r,{title:null===(y=O.context)||void 0===y?void 0:y.name,to:null===(k=O.context)||void 0===k?void 0:k.uri,className:an,draggable:!0,onDragStart:q,onClick:function(){var e;return Y("context_link",null===(e=O.context)||void 0===e?void 0:e.uri)},children:[(0,U.jsx)($n.t,{type:null===(C=zn().from(null===(E=O.context)||void 0===E?void 0:E.uri))||void 0===C?void 0:C.type,iconSize:16,className:tn}),(0,U.jsx)("span",{dir:"auto",className:"ellipsis-one-line",children:null===(D=O.context)||void 0===D?void 0:D.name})]})})})})]})]},_.user.uri):null};function oi(e){var n=e.friends,i=e.isCollapsed,t=e.spec;return(0,U.jsx)(Mn.U5,{flipKey:n.map((function(e){return e.user.uri})).join(""),children:(0,U.jsx)("ol",{children:n.map((function(e,n){return(0,U.jsx)(Mn.$3,{flipId:e.user.uri,children:(0,U.jsx)("li",{children:(0,U.jsx)(ci,{friend:e,show:n<100,isCollapsed:i,spec:t},e.user.uri)})},e.user.uri)}))})})}var di="buddyfeed-visible",ui=parseInt(F,10);const fi=function(e){var n=e.initialFriends,i=(0,a.useRef)(null),s=(0,x.o)(),C=(0,v.n)(),E=(0,y.z)("buddy-feed-width",ui),D=(0,r.Z)(E,2),I=D[0],S=D[1],w=Rn(n),_=I===B,A=(0,k.r)().setValue,F=(0,N.$P)(),L=(0,N.fU)(f.createDesktopFriendActivityEventFactory,{}).spec;(0,a.useEffect)((function(){return(0,g.T)([di]),function(){(0,g.Y)([di])}}),[]),(0,a.useEffect)((function(){s({intent:"view",type:"impression",itemIdSuffix:"buddyfeed"})}),[s]);var O=(0,a.useState)(!1),T=(0,r.Z)(O,2),z=T[0],P=T[1],Z=function(){z||F.logInteraction(L.addFriendButtonFactory().hitUiReveal()),P(!z)},M=0===w.length,Y=(0,a.useCallback)((function(){A("ui.show_friend_feed",!1),F.logInteraction(L.closeButtonFactory().hitUiHide())}),[F,A,L]);return(0,U.jsx)(j.DJ.Provider,{value:"buddy_feed",children:(0,U.jsxs)("aside",{"aria-label":m.ag.get("buddy-feed.friend-activity"),className:Te,children:[(0,U.jsx)(R,{elementRef:i,size:I,setSize:S,isBuddyFeedEmpty:M,showAddFriends:z}),(0,U.jsx)("div",{ref:i,className:l()(ze,(0,t.Z)({},cn,M)),tabIndex:-1,children:(0,U.jsxs)(Fn,{page:z?1:0,children:[(0,U.jsx)("div",{className:Je,children:(0,U.jsx)(Oe,{onBackButtonClick:Z,feedIsEmpty:M,goToAddFriends:z})}),(0,U.jsxs)("div",{className:Ke,children:[!_&&(0,U.jsxs)("div",{className:l()(Pe),children:[(0,U.jsx)(c.D,{as:"h1",variant:"balladBold",className:l()(Re),children:m.ag.get("buddy-feed.friend-activity")}),!C&&(0,U.jsx)(b._,{label:m.ag.get("buddy-feed.add-friends"),children:(0,U.jsx)(p.E,{ariaLabel:m.ag.get("buddy-feed.add-friends"),className:l()(sn),testId:"add-friends-button",size:"sm",onClick:Z,icon:o.t})}),(0,U.jsx)(b._,{label:m.ag.get("buddy-feed.close"),children:(0,U.jsx)(p.E,{ariaLabel:m.ag.get("buddy-feed.close"),className:l()(sn),size:"sm",onClick:Y,icon:d.k})})]}),(0,U.jsxs)(h.U,{className:Me,children:[(0,U.jsx)("div",{className:ln,children:(0,U.jsx)(p.E,{ariaLabel:m.ag.get("buddy-feed.add-friends"),className:on,size:"sm",onClick:Z,icon:o.t})}),M?(0,U.jsx)(yn,{}):(0,U.jsx)(oi,{friends:w,isCollapsed:_,spec:L})]}),C&&!_&&(0,U.jsx)("div",{className:We,children:(0,U.jsx)(u.P,{className:qe,"data-testid":"add-friends-button",buttonSize:"sm",onClick:Z,title:m.ag.get("buddy-feed.find-friends"),children:m.ag.get("buddy-feed.find-friends")})})]})]})})]})})}}}]);
//# sourceMappingURL=xpui-routes-buddy-feed.js.map