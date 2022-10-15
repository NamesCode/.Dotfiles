"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[6450],{15546:(e,n,r)=>{r.d(n,{q:()=>C});var t=r(4942),i=(r(23157),r(68309),r(82526),r(41817),r(26699),r(32023),r(27852),r(47941),r(57327),r(41539),r(38880),r(89554),r(54747),r(49337),r(33321),r(69070),r(69518)),o=r.n(i),s=r(63495),a=r(36590),u=r(8498),c=r(21610),l=r(16257),d=r(85893),f=function(e){var n=e.name,r=void 0===n?"":n,t=e.uri,i=void 0===t?"":t,o=e.images,s=void 0===o?[]:o,f=e.isHero,m=e.onClick,p=e.testId,v=e.index;return f?(0,d.jsx)(c.Z,{featureIdentifier:"unknown",index:v,onClick:m,headerText:r,uri:i,isPlayable:!1,renderCardImage:function(){return(0,d.jsx)(u.x,{isHero:f,images:s})},renderSubHeaderContent:function(){return(0,d.jsx)(l.k,{})},testId:p}):(0,d.jsx)(a.C,{index:v,featureIdentifier:"unknown",onClick:m,headerText:r,uri:i,isPlayable:!1,renderCardImage:function(){return(0,d.jsx)(u.x,{isHero:f,images:s})},renderSubHeaderContent:function(){return(0,d.jsx)("span",{})},testId:p})},m=r(74895),p=r(143),v=r(64269),g=r(3634),x=r(89477),h=r(61864),b=function(e){var n=e.name,r=e.uri,t=e.href,i=e.images,o=e.isHero,s=e.testId,c=e.description,l=e.index,f=e.requestId,m=e.color;return(0,d.jsx)(a.C,{index:l,featureIdentifier:"merch",onClick:function(){window.location.href=t},headerText:n,uri:r,isPlayable:!1,renderCardImage:function(){return(0,d.jsx)(u.x,{isHero:o,images:i,color:m})},renderSubHeaderContent:function(){return(0,d.jsx)("span",{children:c||""})},testId:s,requestId:f,delegateNavigation:!0})},j=r(46309),y=r(30523),O=r(52778),w=r(95332),I=r(97891);function P(e,n){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);n&&(t=t.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),r.push.apply(r,t)}return r}function k(e){for(var n=1;n<arguments.length;n++){var r=null!=arguments[n]?arguments[n]:{};n%2?P(Object(r),!0).forEach((function(n){(0,t.Z)(e,n,r[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):P(Object(r)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(r,n))}))}return e}var C=function(e){var n=e.entity,r=e.index,t=e.testId,i=e.isHero,a=void 0!==i&&i,u=(o().from(n.uri)||{}).type,c={testId:t,isHero:a,index:r,sharingInfo:n.sharingInfo};if(("string"==typeof n.uri||n.uri instanceof String)&&n.uri.startsWith("spotify:merch:"))return(0,d.jsx)(b,k(k({},c),{},{name:n.name,uri:n.uri,href:n.href,images:n.images,description:n.description}));switch(u){case o().Type.ALBUM:case o().Type.COLLECTION_ALBUM:var l=n;return(0,d.jsx)(g.r,k(k({},c),{},{name:l.name,uri:l.uri,images:l.images,artists:l.artists}));case o().Type.ARTIST:var P=n;return(0,d.jsx)(x.I,k(k({},c),{},{name:P.name,uri:P.uri,images:P.images}));case o().Type.EPISODE:var C,D,E=n;return(0,d.jsx)(h.B,k(k({},c),{},{name:E.name,uri:E.uri,images:E.images,showImages:(null===(C=E.show)||void 0===C?void 0:C.images)||[],durationMilliseconds:E.duration_ms,releaseDate:E.release_date,resume_point:E.resume_point,description:E.description,isExplicit:E.explicit,is19PlusOnly:!(null===(D=E.tags)||void 0===D||!D.includes("MOGEF-19+"))}));case o().Type.PLAYLIST:case o().Type.PLAYLIST_V2:var T,A,S=n,N=(null===(T=S.owner)||void 0===T?void 0:T.display_name)||(null===(A=n.owner)||void 0===A?void 0:A.displayName)||"";return(0,d.jsx)(j.Z,k(k({},c),{},{name:S.name,uri:S.uri,images:S.images,description:S.description,authorName:N}));case o().Type.USER:return(0,d.jsx)(y.P,k(k({},c),{},{name:n.name,uri:n.uri,images:n.images}));case o().Type.SHOW:var L,H=n;return(0,d.jsx)(w._,k(k({},c),{},{name:H.name,uri:H.uri,images:H.images,publisher:H.publisher,mediaType:null!==(L={audio:p.E.AUDIO,video:p.E.VIDEO,mixed:p.E.MIXED}[H.media_type])&&void 0!==L?L:p.E.AUDIO}));case o().Type.APPLICATION:return(0,d.jsx)(s.s,k(k({},c),{},{name:n.name,uri:n.uri,images:n.images,description:n.description}));case o().Type.RADIO:return(0,d.jsx)(O.I,{testId:t,index:r,name:n.name,uri:n.uri,images:n.images});case o().Type.TRACK:var M,Z,q=n;return(0,d.jsx)(I.G,k(k({},c),{},{name:q.name,uri:q.uri,images:(null===(M=q.album)||void 0===M?void 0:M.images)||[],artists:q.artists,album:q.album,isExplicit:q.explicit,is19PlusOnly:null===(Z=q.tags)||void 0===Z?void 0:Z.includes("MOGEF-19+")}));case o().Type.COLLECTION:return n.uri.endsWith("your-episodes")?(0,d.jsx)(v.T,{index:r}):(0,d.jsx)(m.p,{index:r});default:return console.warn("Rendering a generic Card for unknown type:",u),(0,d.jsx)(f,k(k({},c),{},{name:n.name,uri:n.uri,images:n.images}))}}},63495:(e,n,r)=>{r.d(n,{s:()=>c});r(68309),r(82526),r(41817);var t=r(96206),i=r(36590),o=r(8498),s=r(21610),a=r(16257),u=r(85893),c=function(e){var n=e.name,r=e.uri,c=e.images,l=e.isHero,d=e.onClick,f=e.testId,m=e.description,p=e.index,v=e.requestId,g=e.color;return l?(0,u.jsx)(s.Z,{featureIdentifier:"genre",index:p,onClick:d,headerText:n,uri:r,isPlayable:!1,renderCardImage:function(){return(0,u.jsx)(o.x,{isHero:l,images:c,color:g})},renderSubHeaderContent:function(){return(0,u.jsx)(a.k,{children:m||t.ag.get("card.tag.genre")})},testId:f,requestId:v}):(0,u.jsx)(i.C,{index:p,featureIdentifier:"genre",onClick:d,headerText:n,uri:r,isPlayable:!1,renderCardImage:function(){return(0,u.jsx)(o.x,{isHero:l,images:c,color:g})},renderSubHeaderContent:function(){return(0,u.jsx)("span",{children:m||""})},testId:f,requestId:v})}},70369:(e,n,r)=>{r.d(n,{$:()=>t.$});var t=r(22578)},82630:(e,n,r)=>{r.r(n),r.d(n,{DISALLOWED_VIEWS:()=>K,View:()=>J,default:()=>X});var t=r(4942),i=(r(57327),r(41539),r(68309),r(5212),r(26699),r(32023),r(79753),r(27852),r(67294)),o=r(94184),s=r.n(o),a=r(86706),u=r(14908),c=r(96206),l=r(95888),d=r(37081),f=r(49552),m=r(70937),p=r(15852),v=r(21794),g=r(70369),x=r(60289),h=r(59482),b=r(72907),j=r(6158),y=(r(74916),r(15306),r(23157),r(21249),r(82526),r(41817),r(47941),r(38880),r(89554),r(54747),r(49337),r(33321),r(69070),r(15546)),O=r(18686),w=r(42922),I=r(32667),P=r(87577),k=r(49207),C=r(67892);const D="EPMDgp7znILo0hvyirzv",E="noUm6pjQ6KWq7mVxYDor",T="PqnKjxzJ1Zvr9qKRlRbO",A="uuBQS9Ym_VPmAQrLhPQb";var S=r(85893);function N(e,n){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);n&&(t=t.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),r.push.apply(r,t)}return r}function L(e){for(var n=1;n<arguments.length;n++){var r=null!=arguments[n]?arguments[n]:{};n%2?N(Object(r),!0).forEach((function(n){(0,t.Z)(e,n,r[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):N(Object(r)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(r,n))}))}return e}var H=function(e){return(0,P.W6)(k.sE)?(0,S.jsxs)(C.Z,{to:e.uri,target:"_blank",className:D,children:[(0,S.jsx)("div",{className:E}),(0,S.jsx)(I.D,{className:T,as:"h2",variant:"alto",children:e.label}),(0,S.jsx)(I.D,{className:A,as:"p",variant:"mesto",children:e.tagline})]}):null},M=function(e){return(0,S.jsx)(i.Suspense,{fallback:null,children:(0,S.jsx)(H,L({},e))})};function Z(e,n){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);n&&(t=t.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),r.push.apply(r,t)}return r}function q(e){for(var n=1;n<arguments.length;n++){var r=null!=arguments[n]?arguments[n]:{};n%2?Z(Object(r),!0).forEach((function(n){(0,t.Z)(e,n,r[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):Z(Object(r)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(r,n))}))}return e}var _=function(e){var n;return null===(n=e.id)||void 0===n?void 0:n.startsWith("scc-corona")},R=function(e){var n=e.spaces,r=e.viewName,t=e.viewId,o=e.isAnonymous,s=(0,i.useCallback)((function(e,n){var r=function(e,n){var r=e.uri;return e.href.includes("https://api.spotify.com/v1/views/")&&(r=e.href.replace("https://api.spotify.com/v1/views/","spotify:genre:"),"hub-browse-grid"===n&&(r=r.replace(":view:",":genre:"))),r}(e,t);return(0,S.jsx)(y.q,{index:n,entity:q(q({},e),{},{uri:r})},e.href)}),[t]),a=(0,i.useCallback)((function(e,n){return(0,S.jsx)(w.JL,{value:"card",index:n,children:(0,S.jsx)(y.q,{index:n,entity:e})},e.uri||n)}),[]),u=(0,i.useCallback)((function(e,n){return"link"===e.type?s(e,n):a(e,n)}),[a,s]),c=(0,i.useCallback)((function(e){return!!_(e)||!(function(e){return"HEADER"===e.rendering}(e)||0===e.content.total||o&&"uniquely-yours-shelf"===e.id)}),[o]);return n&&0!==n.length?n[0].content?(0,S.jsx)(S.Fragment,{children:n.filter(c).map((function(e,n){var r=e.content&&(0,v.p)((0,v.S)(e.href));if(_(e)){var i=e.content.items[0];return i&&i.name&&i.description&&i.href?(0,S.jsx)(M,{label:i.name,tagline:i.description,uri:i.href},"corona-banner"):null}return(0,S.jsx)(w.JL,{value:"headered-grid",index:n,children:(0,S.jsx)(O.q,{total:e.content.total,seeAllUri:r,pageId:t,title:e.name,tagline:e.tag_line||void 0,index:n,id:e.id,children:e.content.items.map(u)})},e.id)}))}):(0,S.jsx)(w.JL,{value:"headered-grid",children:(0,S.jsx)(O.q,{showAll:!0,title:r,total:(null==n?void 0:n.length)||0,index:0,id:null!=t?t:"spaces-see-all-grid",children:null==n?void 0:n.map(u)})}):null},W=r(29255);const F="XD65NhAD6ebYxMaW9cZZ",U="AJqEY1gblQDvIgjU0jAH",G="Ft1cMGlqDsCbqmXQyeKN",V="zlBEnsMyvUhuHSEtst4Q",Y="INYpiFRlwWIZ0vH30xW2";var B=function(e){return"HEADER"===e.rendering},Q=function(e){var n=arguments.length>1&&void 0!==arguments[1]?arguments[1]:[],r=arguments.length>2?arguments[2]:void 0;if(!e)return(0,S.jsx)("div",{className:Y});var t=n.filter((function(e){return"background"===e.name}));return(0,S.jsxs)(x.gF,{backgroundImages:t,backgroundColor:r,size:0===t.length?x.fR.SMALL:x.fR.DEFAULT,children:[(0,S.jsx)(h.W,{children:(0,S.jsx)(b.i,{text:e})}),(0,S.jsx)(x.sP,{children:(0,S.jsx)(x.xd,{children:e})})]})},z=function(e){var n=e.title,r=e.images,t=e.backgroundColor;return(0,S.jsx)(S.Fragment,{children:Q(n,r,t)})},K=["ginger-genre-affinity"],J=i.memo((function(e){var n=e.viewData,r=e.viewId,o=e.backgroundColor,a=e.isFullyLoaded,f=e.isGenre,v=e.isAnonymous,h=e.getNextPage,b=null==n?void 0:n.name,y=(0,p.fU)(u.createDesktopGenreEventFactory,{data:{identifier:r,uri:"spotify:genre:".concat(r)}}),O=y.spec,w=y.UBIFragment,I=(0,i.useCallback)((function(){return K.some((function(e){var r;return null==n||null===(r=n.href)||void 0===r?void 0:r.includes(e)}))}),[n]),P=(0,i.useCallback)((function(){if(n){var e=I();a||e||h()}}),[n,I,a,h]),k=(0,i.useMemo)((function(){var e=(n||{}).content,r=(e=void 0===e?{}:e).items,t=(void 0===r?[]:r).filter(B);return t.length>0?t[0]:null}),[n]),C=(0,i.useMemo)((function(){var e=(n||{}).name;return k?k.name:o&&e}),[o,k,n]),D=(0,i.useMemo)((function(){return f||Boolean(C)}),[f,C]),E=(0,i.useMemo)((function(){return!(!n||!Array.isArray(n.content.items))&&D}),[D,n]),T=(0,x.oX)(r)?(0,S.jsx)(x.YD,{isAnonymous:v}):(0,S.jsx)(z,{title:(null==k?void 0:k.name)||C,images:(null==k?void 0:k.images)||[],backgroundColor:o}),A=null==n?void 0:n.content.items,N=(0,i.useMemo)((function(){return O.shelvesFactory()}),[O]);return n?(0,S.jsxs)(S.Fragment,{children:[b?(0,S.jsx)(g.$,{children:b}):null,(0,S.jsx)(m.C,{onReachBottom:P,children:(0,S.jsxs)("section",{className:F,children:[E&&(0,S.jsx)(d.H,{color:o||null}),D?T:(0,S.jsx)("div",{className:Y}),(0,S.jsxs)("div",{className:G,children:[D&&T&&(0,S.jsx)(l.I,{backgroundColor:o}),(0,S.jsx)("div",{className:s()(U,"contentSpacing",(0,t.Z)({},V,f)),children:(0,S.jsx)(w,{spec:N,children:(0,S.jsx)(R,{spaces:A,viewName:n.name,viewId:r,isAnonymous:v})})})]})]})})]}):(0,S.jsx)(j.h,{hasError:!1,errorMessage:c.ag.get("error.not_found.title.page")})}));const X=i.memo((function(e){var n=e.viewId,r=(0,a.v9)(W.Gg).isAnonymous,t=(0,f.P)(n),i=t.view,o=t.getNextPage,s=!i||null===i.content.next,u=n.endsWith("-page")?n:"".concat(n,"-page"),c=(0,a.v9)((function(e){var n,r;return(null===(n=e.browse.allItemsStyle)||void 0===n||null===(r=n[u])||void 0===r?void 0:r.color)||""})),l=function(e){return e.viewId===n||"href"in e&&e.href===(0,v.p)(n)},d=(0,a.v9)((function(e){var n,r,t,i;return(null==e||null===(n=e.browse)||void 0===n||null===(r=n.browseAll)||void 0===r?void 0:r.items.some(l))||(null==e||null===(t=e.browse)||void 0===t||null===(i=t.topGenres)||void 0===i?void 0:i.items.some(l))||!!c}));return(0,S.jsx)(J,{viewData:i,isFullyLoaded:s,viewId:n,backgroundColor:c,isGenre:d,isAnonymous:r,getNextPage:o})}))},49552:(e,n,r)=>{r.d(n,{P:()=>h});var t=r(4942),i=r(15861),o=(r(85827),r(41539),r(92222),r(47941),r(82526),r(57327),r(38880),r(89554),r(54747),r(49337),r(33321),r(69070),r(87757)),s=r.n(o),a=r(67294),u=r(88767),c=r(87961),l=r(40254),d=(r(69600),r(86706)),f=r(87577),m=r(94321),p=r(29255),v=r(8247);function g(e,n){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var t=Object.getOwnPropertySymbols(e);n&&(t=t.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),r.push.apply(r,t)}return r}function x(e){for(var n=1;n<arguments.length;n++){var r=null!=arguments[n]?arguments[n]:{};n%2?g(Object(r),!0).forEach((function(n){(0,t.Z)(e,n,r[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):g(Object(r)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(r,n))}))}return e}var h=function(e,n){var r,t,o,c,l,g,h,j,O,w=(o=(0,f.W6)(v.Xf),c=(0,d.v9)(m.rZ),l=(0,d.v9)(p.Gg),g=l.locale,h=l.overrides,j=(null==h?void 0:h.country)||c,O=(null==h?void 0:h.locale)||g,(0,a.useMemo)((function(){var e=["album","playlist","artist","show","station","episode","merch"];return o&&e.push("uri_link"),{country:j,locale:O,types:e.join(",")}}),[j,o,O])),I=(0,u.useInfiniteQuery)(["useView",e,w],function(){var n=(0,i.Z)(s().mark((function n(r){var t,i;return s().wrap((function(n){for(;;)switch(n.prev=n.next){case 0:return t=r.pageParam,i=void 0===t?void 0:t,n.abrupt("return",void 0===i?b(e,w):y(i));case 2:case"end":return n.stop()}}),n)})));return function(e){return n.apply(this,arguments)}}(),{cacheTime:null!==(r=null==n?void 0:n.cacheTime)&&void 0!==r?r:18e5,staleTime:null!==(t=null==n?void 0:n.staleTime)&&void 0!==t?t:3e5,getNextPageParam:function(e){var n;return null!==(n=e.content.next)&&void 0!==n?n:void 0},getPreviousPageParam:function(e){var n;return null!==(n=e.content.previous)&&void 0!==n?n:void 0}}),P=I.data,k=I.fetchNextPage;return{view:(0,a.useMemo)((function(){return null==P?void 0:P.pages.reduce((function(e,n){return x(x({},e),{},{content:x(x({},e.content),{},{href:n.content.href,next:n.content.next,offset:n.content.offset,previous:n.content.previous,total:n.content.total,items:e.content.items.concat(n.content.items)})})}))}),[null==P?void 0:P.pages]),getNextPage:k}};function b(e,n){return j.apply(this,arguments)}function j(){return(j=(0,i.Z)(s().mark((function e(n,r){var t,i;return s().wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,l.kO.getView(c.b.getInstance(),n,r);case 2:return t=e.sent,i=t.body,e.abrupt("return",i);case 5:case"end":return e.stop()}}),e)})))).apply(this,arguments)}function y(e){return O.apply(this,arguments)}function O(){return(O=(0,i.Z)(s().mark((function e(n){var r,t;return s().wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,l.TV.getGeneric(c.b.getInstance(),n);case 2:return r=e.sent,t=r.body,e.abrupt("return",t);case 5:case"end":return e.stop()}}),e)})))).apply(this,arguments)}},70937:(e,n,r)=>{r.d(n,{C:()=>d});var t=r(4942),i=r(67294),o=r(97650),s=r(94184),a=r.n(s);const u="eqw9lvuoZHrkWMTdyTpY",c="lb08f71wES9AQnKx6e0R";var l=r(85893),d=i.memo((function(e){var n,r=e.triggerOnInitialLoad,s=void 0!==r&&r,d=e.onReachBottom,f=e.showScrollbar,m=void 0===f||f,p=e.horizontalScroll,v=void 0!==p&&p,g=e.className,x=(0,o.YD)({initialInView:s}),h=x.ref,b=x.inView;return(0,i.useEffect)((function(){b&&d&&d()}),[b,d]),(0,l.jsxs)("div",{className:a()((n={},(0,t.Z)(n,c,!m),(0,t.Z)(n,u,v),n),g),"data-testid":"infinite-scroll-list",children:[e.children,(0,l.jsx)("div",{ref:h})]})}))}}]);
//# sourceMappingURL=xpui-routes-view.js.map