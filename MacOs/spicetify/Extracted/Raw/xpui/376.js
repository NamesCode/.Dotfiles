"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[376],{43914:(e,n,t)=>{t.d(n,{D:()=>u});var r=t(67294),i=t(96206),a=t(65830),l=t(88503),o=t(92823),c=t(53678),s=t(85893),u=function(e){var n=e.id,t=e.children,u=e.targetURI,d=e.fadeOut,m=void 0!==d&&d,f=(0,r.useCallback)((function(){window.open((0,l.cd)(u).href)}),[u]),p={getTitle:function(){return i.ag.get("action-trigger.available-in-app-only")},getDescription:function(){return i.ag.get("action-trigger.listen-mixed-media-episode")},primaryButtonText:function(){return i.ag.get("action-trigger.button.get-app")},secondaryButtonText:function(){return i.ag.get("action-trigger.button.not-now")},isCTA:!0,intentPrimaryButton:"download-app",onLogInteraction:(0,o.o)(),shouldHideOnScroll:!0,fadeOut:m};return(0,s.jsx)(a.P,{className:c.Z.container,id:n,onPrimaryButtonClick:f,options:p,children:t})}},22578:(e,n,t)=>{t.d(n,{$:()=>f});t(26699),t(32023),t(69600),t(68309),t(21249);var r=t(64593),i=t(96206),a=t(69691),l=t(8341),o=t(89952),c=t(67294),s=t(51615),u=t(24183),d=t(85893);function m(e){return e.includes("Spotify")?e:"Spotify – ".concat(e)}var f=function(e){var n,t,f,p,g,h,v,b=e.children,y=e.usePlayingItem,j=m(b);n=b,p=(0,u.Oh)().mainLandmarkRef,g=(0,s.k6)(),h=null===(t=g.location)||void 0===t||null===(f=t.state)||void 0===f?void 0:f.preventMoveFocus,(v=(0,c.useRef)(g.length<2)).current=g.length<2,(0,c.useEffect)((function(){var e=p.current;!h&&!v.current&&e&&n&&(e.setAttribute("aria-label",n),e.focus())}),[n,p,h]);var x=(0,a.IK)().isPlaying,O=(0,l.Y)((function(e){return null==e?void 0:e.item}));return O&&(x||y)&&((0,o.G_)(O)?j=[O.name,O.artists.map((function(e){return e.name})).join(i.ag.getSeparator())].join(" • "):(0,o.iw)(O)?j=[O.name,O.show.name].join(" • "):(0,o.k6)(O)&&(j=m(i.ag.get("ad-formats.advertisement")))),(0,d.jsx)(r.q,{defaultTitle:"Spotify",defer:!1,children:(0,d.jsx)("title",{children:j})})}},70369:(e,n,t)=>{t.d(n,{$:()=>r.$});var r=t(22578)},61348:(e,n,t)=>{t.d(n,{w:()=>h});t(23157);var r=t(67294),i=t(65598),a=t.n(i),l=t(32667),o=(t(69600),t(21249),t(74916),t(23123),t(4723),t(15306),/(\((?:[0-9]{1,3}:){1,2}[0-9]{2}\))/g);var c=t(99027),s=t(67892);const u="playlist-playlist-playlistDescription",d="QD13ZfPiO5otS0PU89wG",m="ZbLneLRe2x_OBOYZMX3M",f="rjdQaIDkSgcGmxkdI2vU",p="umouqjSkMUbvF4I_Xz6r";var g=t(85893),h=r.memo((function(e){var n=e.html,t=e.onTimeStampClick,i=e.enableTimestamps,l=void 0!==i&&i,c=e.semanticColor,s=void 0===c?"textSubdued":c,d=(0,r.useMemo)((function(){var e,r=l?n.split(o).map((function(e){if(e.match(o)){var n=e.replace("(","").replace(")","");return"(<time>".concat(n,"</time>)")}return e})).join(""):n;try{e=a()(r,{transform:v(t,s),dangerouslySetChildren:[]})}catch(t){e=n}return e}),[l,n,t,s]);return(0,g.jsx)("div",{className:u,children:d})}));function v(e,n){var t=0;return{p:function(e){return(0,g.jsx)(l.D,{as:"p",variant:"ballad",semanticColor:n,className:p,children:e.children})},a:function(n){var t;return null!==(t=n.href)&&void 0!==t&&t.startsWith("#t=")?(0,g.jsx)(c.E,{onClick:e,children:n.children}):n.href?(0,g.jsx)(s.r,{to:n.href,children:n.children}):(0,g.jsx)(g.Fragment,{children:n.children})},ul:function(e){return(0,g.jsx)("ul",{className:m,children:e.children})},ol:function(e){return(0,g.jsx)("ol",{className:m,children:e.children})},li:function(e){return(0,g.jsx)(l.D,{as:"li",variant:"ballad",semanticColor:n,className:f,children:e.children})},br:function(){return(0,g.jsx)("br",{})},h1:function(e){return(0,g.jsx)(l.D,{as:"h1",variant:"balladBold",semanticColor:n,className:d,children:e.children})},h2:function(e){return(0,g.jsx)(l.D,{as:"h2",variant:"balladBold",semanticColor:n,className:d,children:e.children})},h3:function(e){return(0,g.jsx)(l.D,{as:"h3",variant:"balladBold",semanticColor:n,className:d,children:e.children})},h4:function(e){return(0,g.jsx)(l.D,{as:"h4",variant:"balladBold",semanticColor:n,className:d,children:e.children})},h5:function(e){return(0,g.jsx)(l.D,{as:"h5",variant:"balladBold",semanticColor:n,className:d,children:e.children})},h6:function(e){return(0,g.jsx)(l.D,{as:"h6",variant:"balladBold",semanticColor:n,className:d,children:e.children})},time:function(n){return(0,g.jsx)(c.E,{onClick:e,children:n.children})},_:function(e,n,i){var a=void 0===n?e:i;return(0,g.jsx)(r.Fragment,{children:a},"fragment".concat(t++))}}}},31610:(e,n,t)=>{t.d(n,{o:()=>m,q:()=>o.q});t(47941),t(82526),t(57327),t(41539),t(38880),t(89554),t(54747),t(49337),t(33321),t(69070);var r=t(4942),i=t(29439),a=t(67294),l=t(4383),o=t(43683),c=t(92823),s=t(85893);function u(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}var d=a.memo((function(e){var n=e.uri,t=e.bookUri,r=e.size,u=void 0===r?o.q.md:r,d=e.className,m=e.onClick,f=void 0===m?function(){}:m,p=e.isLocked,g=void 0===p||p,h=(0,l.Z)(t),v=(0,i.Z)(h,2),b=v[0],y=v[1],j=(0,c.o)(),x=(0,a.useCallback)((function(){j({targetUri:t,intent:"add-to-library",type:"click"}),y(!0)}),[j,t,y]);return(0,s.jsx)(o.o,{className:d,isFollowing:b,canDownload:!g,onFollow:x,uri:n,size:u,onClick:f})})),m=a.memo((function(e){return(0,s.jsx)(d,function(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?u(Object(t),!0).forEach((function(n){(0,r.Z)(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):u(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}({},e))}))},11486:(e,n,t)=>{t.d(n,{V:()=>c});t(82526),t(41817);var r=t(69518),i=t.n(r),a=t(87577),l=t(8247),o=t(42781),c=function(e,n){if(!(0,a.W6)(l.sT,{loadingValue:!1})||!n)return null;if("episode"===e&&n.type===o.p.EPISODE&&"Made on Spotify"===n.description){var t=i().from(n.uri),r=null==t?void 0:t.id;return r?"/user-song/".concat(r):null}if("show"===e&&n.type===o.p.SHOW&&"All songs recorded, edited, and published on Spotify."===n.description){var c=i().from("spotify:user:".concat(n.publisherName));return i().from(c).toURLPath(!0)}return null}},87834:(e,n,t)=>{t.d(n,{C:()=>l});var r=t(67294),i=t(94960),a=t(85893),l=function(e){var n=e.pageId,t=e.uri,l=e.children,o=(0,i.b)(),c=(0,i.H)();return(0,r.useEffect)((function(){null==o||o.reportPageView({pageId:n,navigationalRoot:null!=c?c:void 0,entityUri:t})}),[n,c,o,t]),(0,a.jsx)(a.Fragment,{children:l})}},80219:(e,n,t)=>{t.d(n,{s:()=>g});var r=t(67294),i=t(92823),a=t(4942),l=(t(96647),t(83710),t(41539),t(39714),t(68309),t(69826),t(47941),t(82526),t(57327),t(38880),t(89554),t(54747),t(49337),t(33321),t(69070),function(e){return e<=64?"small":e>640?"xlarge":e>300?"large":"standard"});function o(e,n){return e.filter((function(e){return e.label?e.label===n:e.width?l(e.width)===n:!!e.height&&l(e.height)===n}))[0]}var c=t(67789);t(2707);function s(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function u(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?s(Object(t),!0).forEach((function(n){(0,a.Z)(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):s(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function d(e){var n,t,r,i,a,l,c,s,u=o(e,"standard"),d=o(e,"large"),m=o(e,"small"),f=o(e,"xlarge");return{image_url:null==u?void 0:u.url,image_height:null==u||null===(n=u.height)||void 0===n?void 0:n.toString(),image_width:null==u||null===(t=u.width)||void 0===t?void 0:t.toString(),image_url_large:null==d?void 0:d.url,image_height_large:null==d||null===(r=d.height)||void 0===r?void 0:r.toString(),image_width_large:null==d||null===(i=d.width)||void 0===i?void 0:i.toString(),image_url_small:null==m?void 0:m.url,image_height_small:null==m||null===(a=m.height)||void 0===a?void 0:a.toString(),image_width_small:null==m||null===(l=m.width)||void 0===l?void 0:l.toString(),image_url_xlarge:null==f?void 0:f.url,image_height_xlarge:null==f||null===(c=f.height)||void 0===c?void 0:c.toString(),image_width_xlarge:null==f||null===(s=f.width)||void 0===s?void 0:s.toString()}}var m=t(23716),f=t(69691),p=t(42781);function g(e,n){var t=(0,i.o)(),a=(0,m.g)(),l=(0,f.$o)((null==e?void 0:e.uri)||""),o=l.isPlaying,s=l.isActive,g=(0,f.cR)((null==n?void 0:n.uri)||"").isActive;return(0,r.useCallback)((function(r){if(n&&e){var i,l,m,f,h,v,b,y,j,x=(l=n,b=((null===(m=(i=e).coverArt)||void 0===m?void 0:m.sources)||[]).sort((function(e,n){return(n.width||0)-(e.width||0)})),y=(0,c.Xb)(i,l),j=(0,c.Ie)(l)||y,u(u({uri:i.uri,title:i.name,subtitle:l.name,type:"episode",album_uri:l.uri,album_title:l.name,artist_uri:l.uri,artist_name:l.name},d(b)),{},{media_type:"audio",externalResolvedUrl:null===(f=i.audio)||void 0===f||null===(h=f.items)||void 0===h||null===(v=h.find((function(e){return e.externallyHosted})))||void 0===v?void 0:v.url,isTrailer:y,anonymousPlaybackAllowed:j}));g&&!o&&s&&!r?a.resume():g&&o&&!r?(t({type:"click",intent:"pause",targetUri:e.uri}),a.pause()):(t({type:"click",intent:"play",targetUri:e.uri}),a.play({uri:n.uri,pages:[{items:[{type:p.p.EPISODE,uri:e.uri,uid:null,metadata:x,provider:null}]}]},{referrerIdentifier:a.getReferrer(),featureIdentifier:"episode"},r))}}),[s,o,g,a,t,n,e])}},51441:(e,n,t)=>{t.d(n,{qE:()=>s,ul:()=>c,JM:()=>h});var r=t(4942),i=t(67294),a=t(94184),l=t.n(a);const o={PlayButton:"main-playButton-PlayButton",primary:"main-playButton-primary",secondary:"main-playButton-secondary",transparent:"main-playButton-transparent",lockIcon:"main-playButton-lockIcon"};var c,s,u=t(96206),d=t(82749),m=t(92386),f=t(15358),p=t(51674),g=t(85893);!function(e){e.primary="primary",e.secondary="secondary",e.transparent="transparent"}(c||(c={})),function(e){e[e.xxs=16]="xxs",e[e.xs=32]="xs",e[e.sm=40]="sm",e[e.md=48]="md",e[e.lg=56]="lg",e[e.xl=64]="xl"}(s||(s={}));var h=i.memo((0,i.forwardRef)((function(e,n){var t=e.onClick,i=e.isPlaying,a=e.locked,h=e.version,v=void 0===h?c.primary:h,b=e.size,y=void 0===b?s.sm:b,j=e.disabled,x=void 0!==j&&j,O=e.children,w=e.ariaPauseLabel,k=e.ariaPlayLabel,P=e.isLoading,S=40===y?16:y/2,C=(0,r.Z)({},"--size","".concat(y,"px")),_=u.ag.get("play");_=a?u.ag.get("mwp.header.content.unavailable"):i?null!=w?w:u.ag.get("pause"):null!=k?k:u.ag.get("play");var T=i?(0,g.jsx)(d.k,{"aria-hidden":!0}):(0,g.jsx)(m.J,{"aria-hidden":!0});return(0,g.jsx)(p._,{label:_,children:(0,g.jsxs)(g.Fragment,{children:[(0,g.jsxs)("button",{style:C,className:l()(o.PlayButton,o[v],"encore-bright-accent-set"),onClick:function(e){var n=e,r=n.currentTarget,i=n.detail;t(e),i>0&&r&&r.blur()},disabled:x||P,"aria-label":_,ref:n,"data-testid":"play-button",children:[T,a&&(0,g.jsx)(f.Z,{color:"black",className:o.lockIcon,iconSize:S})]}),O]})})})))},97656:(e,n,t)=>{t.d(n,{o:()=>S});var r=t(29439),i=t(4942),a=(t(57327),t(41539),t(74916),t(23123),t(15306),t(21249),t(9653),t(47941),t(82526),t(38880),t(89554),t(54747),t(49337),t(33321),t(69070),t(67294)),l=t(96206);const o="CTqnyEX1E8bCstZSENX_",c="wuGkmgD03o8t6Ekc6PUk",s="l1ZEvEBLXHaRxKZTgG2Q",u="KXlcyuHuR1UPYVsnF3zF";var d=t(69559),m=t(32667),f=t(61348),p=t(85893),g=a.memo((function(e){var n=e.text,t=e.onTimeStampClick,r=e.children,i=e.className,l=e.enableTimestamps,o=void 0!==l&&l,c=(0,a.useMemo)((function(){return(0,p.jsx)(f.w,{html:n,onTimeStampClick:t,enableTimestamps:o})}),[n,o,t]);return(0,p.jsxs)(m.D,{as:"div",variant:"ballad",className:i,children:[c,r]})}));t(47042),t(84944),t(33792);const h="AFGg70Z_GfjSDTYBWyEq";var v=(0,a.memo)((function(e){var n=e.text,t=e.onTimeStampClick,r=e.onToggle,i=e.className,a=e.enableTimestamps;return(0,p.jsx)(g,{className:i,text:n,onTimeStampClick:t,enableTimestamps:a,children:(0,p.jsx)("button",{"aria-expanded":!1,className:h,onClick:r,children:(0,p.jsxs)(m.D,{variant:"balladBold",children:["… ",l.ag.get("mwp.see.more")]})})})})),b=function(e,n,t){var r=l.ag.get("mwp.see.more").length,i=e.length+r+6;return t<=1&&i<n},y=(0,a.memo)((function(e){var n=e.paragraphs,t=e.clickHandler,r=e.maxCharactersPerLine,i=e.maxLines,a=e.toggleExpandedState,o=e.className,c=e.enableTimestamps,s=!1,u=0,d=n.map((function(e,d){var m=Math.round(e.length/r);if(u+=m>0?m:1,s)return null;var f=i-(u-m);if(!(d+1===n.length&&(b(e,r,f)||m<=f))&&u>=i){s=!0;var h=function(e,n,t){var r=l.ag.get("mwp.see.more").length;if(b(e,n,t))return e;var i=n*t-r-6;return e.slice(0,i)}(e,r,f);return(0,p.jsx)(v,{text:h,onTimeStampClick:t,onToggle:a,className:o,enableTimestamps:c},d)}return(0,p.jsx)(g,{className:o,text:e,onTimeStampClick:t,enableTimestamps:c},d)})).filter((function(e){return null!==e})).map((function(e,n,t){return n+1===t.length?e:[e," "]})).flat();return(0,p.jsx)(p.Fragment,{children:d})}));function j(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function x(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?j(Object(t),!0).forEach((function(n){(0,i.Z)(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):j(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}var O={isOpen:!1,contentWidth:0},w=function(e,n){return x(x({},e),n)},k=function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"";return e.split(/[ \u00a0]{2}/).filter(Boolean)},P=function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"";return e.replace("<p>","").split(/(?:<\/p>)/).filter(Boolean)},S=(0,a.memo)((function(e){var n=e.content,t=e.htmlContent,i=e.maxLines,h=void 0===i?2:i,v=e.className,b=e.onTimeStampClick,j=void 0===b?function(){}:b,x=e.onExpanded,S=e.enableTimestamps,C=void 0!==S&&S,_=(0,a.useReducer)(w,O),T=(0,r.Z)(_,2),N=T[0],D=T[1],E=N.isOpen,B=N.contentWidth,I=(0,a.useCallback)((function(){D({isOpen:!E}),x&&x(!E)}),[E,x]);(0,a.useEffect)((function(){D({isOpen:!1})}),[n]);var L=B?B/7.8:Number.MAX_VALUE,R=(0,a.useRef)(null),U=(0,a.useCallback)((function(e){e&&(R.current=e,D({contentWidth:e.clientWidth}))}),[]),Z=(0,a.useMemo)((function(){return t?P(t).map((function(e){return(0,p.jsx)(f.w,{html:e,onTimeStampClick:j,enableTimestamps:C})})):function(e,n,t){return k(e).map((function(e,r){return(0,p.jsx)(g,{className:c,text:e,onTimeStampClick:n,enableTimestamps:t},r)}))}(n,j,C)}),[n,C,t,j]),M=(0,a.useMemo)((function(){return t?P(t):k(n)}),[n,t]);return(0,d.a)((function(){R.current&&D({contentWidth:R.current.clientWidth})})),(0,p.jsx)("div",{className:v,children:(0,p.jsxs)("div",{ref:U,className:o,children:[E&&(0,p.jsxs)(p.Fragment,{children:[Z,(0,p.jsx)("button",{"aria-expanded":!0,className:u,onClick:I,children:(0,p.jsx)(m.D,{className:s,variant:"balladBold",children:l.ag.get("show_less")})})]}),!E&&(0,p.jsx)(y,{className:c,paragraphs:M,clickHandler:j,enableTimestamps:C,maxCharactersPerLine:L,maxLines:h,toggleExpandedState:I})]})})}))},60410:(e,n,t)=>{t.d(n,{S:()=>i});var r=t(86649);function i(e){var n,t,i;return!(null!==(n=e.playability)&&void 0!==n&&n.playable||(null===(t=e.playability)||void 0===t?void 0:t.reason)!==r.WY.PaymentRequired&&(null===(i=e.playability)||void 0===i?void 0:i.reason)!==r.WY.Anonymous)}}}]);
//# sourceMappingURL=376.js.map