"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[2597],{43683:(e,n,t)=>{t.d(n,{q:()=>w,o:()=>E});var r=t(29439),a=t(4942),i=t(67294),l=t(94184),o=t.n(l),c=t(59440),s=t(97081),d=t(96206),u=t(51674),m=t(79896),h=t(26482),g=t(21663),v=t(88387),f=t(75012),p=t(40080),x=t(14130);const C="l_MW0G9qeeCKlVJwBykT",b="x-downloadButton-DownloadButton",k="x-downloadButton-button",y="_APVWqivXc4YqgsnpFkP",S="VmwiDoU6RpqyzK_n7XRO",j="rEx3EYgBzS8SoY7dmC6x";var w,D=t(85893);!function(e){e[e.xs=16]="xs",e[e.sm=24]="sm",e[e.md=32]="md"}(w||(w={}));var O=function(e){var n=e.currentTarget;e.detail>0&&n&&n.blur()},E=function(e){var n=e.uri,t=e.isFollowing,l=e.canDownload,E=void 0===l||l,_=e.onFollow,N=e.size,A=void 0===N?w.sm:N,T=e.className,I=e.onClick,R=void 0===I?function(){}:I,L=e.showUpsell,P=void 0===L||L,B=(0,a.Z)({},"--size","".concat(A,"px")),Q=(0,i.useState)(!1),Z=(0,r.Z)(Q,2),U=Z[0],M=Z[1],F=(0,g._)(n),Y=F.capability,K=F.availability,X=F.addDownload,z=F.removeDownload,W=(0,v.A)(n);!function(e,n){var t=(0,x.r)(),r=(0,i.useRef)(!1);(0,i.useEffect)((function(){e===h.Om.DOWNLOADING&&!1===r.current&&(r.current=!0,t.say(d.ag.get("download.downloading",n.totalItems)))}),[t,e,n]);var a=(0,p.D)(e);(0,i.useEffect)((function(){a===h.Om.DOWNLOADING&&e===h.Om.YES&&(r.current=!1,t.say(d.ag.get("download.complete")))}),[t,a,e])}(K,W);var G=(0,i.useCallback)((function(e){e.preventDefault(),Y===h.PQ.NO_PERMISSION?R(e,h.mc.NO_PERMISSION):(!1===t?(_(),M(!0)):X(),R(e,h.mc.ADD)),O(e)}),[X,Y,t,R,_]),V=(0,i.useCallback)((function(e){e.preventDefault(),z(),O(e),R(e,h.mc.REMOVE)}),[z,R]);(0,i.useEffect)((function(){!0===U&&!0===t&&(X(),M(!1))}),[t,U,X]);var q=K===h.Om.YES;return Y===h.PQ.NO_CAPABILITY?null:(E||q)&&(Y!==h.PQ.NO_PERMISSION||P)?Y===h.PQ.NO_PERMISSION?(0,D.jsx)("div",{className:b,children:(0,D.jsx)(m.Nt,{offset:[-2,20],action:"toggle",trigger:"click",content:(0,D.jsx)(m.yv,{children:(0,D.jsx)("span",{children:d.ag.get("download.upsell")})}),renderInline:!1,children:(0,D.jsx)("div",{children:(0,D.jsx)(u._,{label:d.ag.get("download.download"),children:(0,D.jsx)("button",{className:o()(k,T),role:"switch",onClick:G,"aria-label":d.ag.get("download.download"),"aria-checked":!1,children:(0,D.jsx)(c.D,{iconSize:A})})})})})}):q?(0,D.jsx)(u._,{label:d.ag.get("download.remove"),children:(0,D.jsx)("button",{className:o()(k,T,y),role:"switch",onClick:V,"aria-label":d.ag.get("download.remove"),"aria-checked":!0,children:(0,D.jsx)(s.E,{iconSize:A})})}):K===h.Om.NO?(0,D.jsx)(u._,{label:d.ag.get("download.download"),children:(0,D.jsx)("button",{className:o()(k,T),role:"switch",onClick:G,"aria-label":d.ag.get("download.download"),"aria-checked":!1,children:(0,D.jsx)(c.D,{iconSize:A})})}):(0,D.jsxs)("div",{className:o()(S,T),role:"switch","aria-checked":!0,children:[(0,D.jsx)(u._,{label:d.ag.get("download.cancel"),children:(0,D.jsx)("button",{style:B,className:o()(k,C,T),onClick:V,"aria-label":d.ag.get("download.cancel")})}),(0,D.jsx)("span",{style:B,className:o()(j,C),children:(0,D.jsx)(f.e,{"aria-valuetext":d.ag.get("progress.downloading-tracks"),percentage:W.percentage,size:A})})]}):null}},22578:(e,n,t)=>{t.d(n,{$:()=>h});t(26699),t(32023),t(69600),t(68309),t(21249);var r=t(64593),a=t(96206),i=t(69691),l=t(8341),o=t(89952),c=t(67294),s=t(51615),d=t(24183),u=t(85893);function m(e){return e.includes("Spotify")?e:"Spotify – ".concat(e)}var h=function(e){var n,t,h,g,v,f,p,x=e.children,C=e.usePlayingItem,b=m(x);n=x,g=(0,d.Oh)().mainLandmarkRef,v=(0,s.k6)(),f=null===(t=v.location)||void 0===t||null===(h=t.state)||void 0===h?void 0:h.preventMoveFocus,(p=(0,c.useRef)(v.length<2)).current=v.length<2,(0,c.useEffect)((function(){var e=g.current;!f&&!p.current&&e&&n&&(e.setAttribute("aria-label",n),e.focus())}),[n,g,f]);var k=(0,i.IK)().isPlaying,y=(0,l.Y)((function(e){return null==e?void 0:e.item}));return y&&(k||C)&&((0,o.G_)(y)?b=[y.name,y.artists.map((function(e){return e.name})).join(a.ag.getSeparator())].join(" • "):(0,o.iw)(y)?b=[y.name,y.show.name].join(" • "):(0,o.k6)(y)&&(b=m(a.ag.get("ad-formats.advertisement")))),(0,u.jsx)(r.q,{defaultTitle:"Spotify",defer:!1,children:(0,u.jsx)("title",{children:b})})}},70369:(e,n,t)=>{t.d(n,{$:()=>r.$});var r=t(22578)},20701:(e,n,t)=>{t.d(n,{T:()=>m});var r=t(29439),a=(t(68309),t(57784)),i=t(37925),l=t(25678),o=t(60289),c=t(23401);const s="profile-editImage-imageContainer",d="profile-editImage-editImageButtonContainer";var u=t(85893),m=function(e){var n=e.onClick,t=e.name,m=e.images,h=e.canEdit,g=e.placeholderType,v=e.shape,f=void 0===v?o.Kc.SQUARE:v,p=e.dragUri,x=void 0===p?"":p,C=(0,i.RH)(m),b=(0,r.Z)(C,2),k=b[0],y=b[1],S=(0,l.VO)(k,y)===l.KO.loaded,j=(0,a.O1)([x],t);return(0,u.jsxs)("div",{className:s,"data-testid":"".concat(g,"-image"),draggable:!!x,onDragStart:j,children:[(0,u.jsx)(o.Oe,{loading:"eager",name:t,images:m,placeholderType:g,shape:f}),h&&(0,u.jsx)("div",{className:d,children:(0,u.jsx)(c.F,{overlay:S,onClick:n,rounded:f===o.Kc.CIRCLE})})]})}},61348:(e,n,t)=>{t.d(n,{w:()=>f});t(23157);var r=t(67294),a=t(65598),i=t.n(a),l=t(32667),o=(t(69600),t(21249),t(74916),t(23123),t(4723),t(15306),/(\((?:[0-9]{1,3}:){1,2}[0-9]{2}\))/g);var c=t(99027),s=t(67892);const d="playlist-playlist-playlistDescription",u="QD13ZfPiO5otS0PU89wG",m="ZbLneLRe2x_OBOYZMX3M",h="rjdQaIDkSgcGmxkdI2vU",g="umouqjSkMUbvF4I_Xz6r";var v=t(85893),f=r.memo((function(e){var n=e.html,t=e.onTimeStampClick,a=e.enableTimestamps,l=void 0!==a&&a,c=e.semanticColor,s=void 0===c?"textSubdued":c,u=(0,r.useMemo)((function(){var e,r=l?n.split(o).map((function(e){if(e.match(o)){var n=e.replace("(","").replace(")","");return"(<time>".concat(n,"</time>)")}return e})).join(""):n;try{e=i()(r,{transform:p(t,s),dangerouslySetChildren:[]})}catch(t){e=n}return e}),[l,n,t,s]);return(0,v.jsx)("div",{className:d,children:u})}));function p(e,n){var t=0;return{p:function(e){return(0,v.jsx)(l.D,{as:"p",variant:"ballad",semanticColor:n,className:g,children:e.children})},a:function(n){var t;return null!==(t=n.href)&&void 0!==t&&t.startsWith("#t=")?(0,v.jsx)(c.E,{onClick:e,children:n.children}):n.href?(0,v.jsx)(s.r,{to:n.href,children:n.children}):(0,v.jsx)(v.Fragment,{children:n.children})},ul:function(e){return(0,v.jsx)("ul",{className:m,children:e.children})},ol:function(e){return(0,v.jsx)("ol",{className:m,children:e.children})},li:function(e){return(0,v.jsx)(l.D,{as:"li",variant:"ballad",semanticColor:n,className:h,children:e.children})},br:function(){return(0,v.jsx)("br",{})},h1:function(e){return(0,v.jsx)(l.D,{as:"h1",variant:"balladBold",semanticColor:n,className:u,children:e.children})},h2:function(e){return(0,v.jsx)(l.D,{as:"h2",variant:"balladBold",semanticColor:n,className:u,children:e.children})},h3:function(e){return(0,v.jsx)(l.D,{as:"h3",variant:"balladBold",semanticColor:n,className:u,children:e.children})},h4:function(e){return(0,v.jsx)(l.D,{as:"h4",variant:"balladBold",semanticColor:n,className:u,children:e.children})},h5:function(e){return(0,v.jsx)(l.D,{as:"h5",variant:"balladBold",semanticColor:n,className:u,children:e.children})},h6:function(e){return(0,v.jsx)(l.D,{as:"h6",variant:"balladBold",semanticColor:n,className:u,children:e.children})},time:function(n){return(0,v.jsx)(c.E,{onClick:e,children:n.children})},_:function(e,n,a){var i=void 0===n?e:a;return(0,v.jsx)(r.Fragment,{children:i},"fragment".concat(t++))}}}},35213:(e,n,t)=>{t.d(n,{l:()=>b});var r,a,i=t(93433),l=(t(40561),t(57327),t(41539),t(21249),t(67294)),o=t(96206),c=t(76119),s=t(4942),d=(t(26699),t(32023),t(78462)),u=t(73785),m={"custom-order":d.HI,title:{column:u.Q.TITLE,order:u.k.ASC},artist:{column:u.Q.TITLE,order:u.k.SECONDARY_ASC},"added-by":{column:u.Q.ADDED_BY,order:u.k.ASC},"added-at":{column:u.Q.ADDED_AT,order:u.k.ASC},duration:{column:u.Q.DURATION,order:u.k.ASC},album:{column:u.Q.ALBUM,order:u.k.ASC},"album-or-podcast":{column:u.Q.ALBUM_OR_PODCAST,order:u.k.ASC},"album-or-show":{column:u.Q.ALBUM_OR_SHOW,order:u.k.ASC}},h={title:u.Q.TITLE,artist:u.Q.TITLE,"added-by":u.Q.ADDED_BY,"added-at":u.Q.ADDED_AT,duration:u.Q.DURATION,album:u.Q.ALBUM,"album-or-podcast":u.Q.ALBUM_OR_PODCAST,"album-or-show":u.Q.ALBUM_OR_SHOW},g=(r={},(0,s.Z)(r,u.k.NONE,u.k.NONE),(0,s.Z)(r,u.k.ASC,u.k.DESC),(0,s.Z)(r,u.k.DESC,u.k.ASC),(0,s.Z)(r,u.k.SECONDARY_ASC,u.k.SECONDARY_DESC),(0,s.Z)(r,u.k.SECONDARY_DESC,u.k.SECONDARY_ASC),r),v=(a={},(0,s.Z)(a,u.Q.INDEX,{key:"custom-order",get value(){return o.ag.get("sort.custom-order")}}),(0,s.Z)(a,u.Q.TITLE,{key:"title",get value(){return o.ag.get("sort.title")}}),(0,s.Z)(a,u.Q.ARTIST,{key:"artist",get value(){return o.ag.get("sort.artist")}}),(0,s.Z)(a,u.Q.ADDED_BY,{key:"added-by",get value(){return o.ag.get("sort.added-by")}}),(0,s.Z)(a,u.Q.ADDED_AT,{key:"added-at",get value(){return o.ag.get("sort.date-added")}}),(0,s.Z)(a,u.Q.DURATION,{key:"duration",get value(){return o.ag.get("sort.duration")}}),(0,s.Z)(a,u.Q.EVENT_DATE,null),(0,s.Z)(a,u.Q.ALBUM,{key:"album",get value(){return o.ag.get("sort.album")}}),(0,s.Z)(a,u.Q.ALBUM_OR_PODCAST,{key:"album-or-podcast",get value(){return o.ag.get("sort.album-or-podcast")}}),(0,s.Z)(a,u.Q.ALBUM_OR_SHOW,{key:"album-or-show",get value(){return o.ag.get("sort.album-or-show")}}),(0,s.Z)(a,u.Q.PLAYS,null),(0,s.Z)(a,u.Q.RELEASE_DATE,null),(0,s.Z)(a,u.Q.ADD,null),(0,s.Z)(a,u.Q.ACTIONS,null),a),f=t(28248),p=t(1838),x=t(85893);function C(e){return!!e}var b=function(e){var n=e.columns,t=e.disabled,r=e.onSort,a=(0,i.Z)(n);a.splice(2,0,f.QD.ARTIST);var s=(0,l.useContext)(d.Gb),b=s.sortState,k=s.setSortState,y=function(e){return null===e.column?v[f.QD.INDEX]:(0,p.cB)(e.column,e.order)?v[f.QD.ARTIST]:v[e.column]}(b),S=(0,l.useCallback)((function(e){null==r||r(),k(function(e,n,t){return e?n!==h[e]||"artist"===e&&[u.k.ASC,u.k.DESC].includes(t)||"title"===e&&[u.k.SECONDARY_ASC,u.k.SECONDARY_DESC].includes(t)?m[e]:{column:h[e],order:g[t]}:d.HI}(e,b.column,b.order))}),[r,k,b.column,b.order]),j=(0,l.useCallback)((function(){return null!==b.column}),[b.column]),w=a.map((function(e){return v[e]})).filter(C);return(0,x.jsx)(c.A,{options:w,onSelect:S,selected:y,isSelectionChanged:j,sortOrder:b.order,heading:o.ag.get("drop_down.sort_by"),disabled:t})}},61728:(e,n,t)=>{t.d(n,{h:()=>p});t(82526),t(41817);var r=t(67294),a=t(94184),i=t.n(a),l=t(32667),o=t(73012),c=t(86025),s=t(34011),d=t(96206),u=t(84465);const m="J0xJcBaKhwl9EIuzvhLg",h="ce3qMCnc2kDVSi7k74fh",g="tlBLfMv0fCxd31jPTQhL",v="AytCc2WKUld6N212Pcpu";var f=t(85893),p=r.memo((function(e){var n=e.onClose,t=e.onRemove,a=e.isOpen,p=e.tracks,x=e.title,C=(0,r.useCallback)((function(e){t(p),n(e)}),[t,n,p]);return(0,f.jsx)(u.Z,{shouldCloseOnEsc:!0,shouldCloseOnOverlayClick:!0,onRequestClose:n,contentLabel:x,isOpen:a,children:(0,f.jsxs)("div",{className:m,children:[(0,f.jsx)(l.D,{as:"h2",variant:"cello",className:h,children:x}),(0,f.jsx)(l.D,{as:"p",variant:"mesto",className:g,paddingBottom:o.g4V,children:d.ag.get("playlist.remove_multiple_description")}),(0,f.jsxs)("div",{className:i()("encore-light-theme",v),children:[(0,f.jsx)(c.o,{onClick:n,children:d.ag.get("playlist.delete-cancel")}),(0,f.jsx)(s.D,{onClick:C,children:d.ag.get("remove")})]})]})})}))},76119:(e,n,t)=>{t.d(n,{A:()=>S});var r=t(4942),a=t(29439),i=t(94184),l=t.n(i),o=t(34142),c=t(47921),s=t(32667),d=t(21965),u=t(20246),m=(t(21249),t(71379)),h=t(78267),g=t(30005),v=t(36652),f=t(21691),p=t(28248),x=t(85893),C=function(e){var n,t=e.heading,r=e.selected,a=e.onSelect,i=e.options,l=e.sortOrder;l&&(l===p.kn.ASC||l===p.kn.SECONDARY_ASC?n=m.C:l!==p.kn.DESC&&l!==p.kn.SECONDARY_DESC||(n=h.B));return(0,x.jsxs)(g.v,{getInitialFocusElement:function(e){return null==e?void 0:e.querySelector('[aria-checked="true"]')},children:[t?(0,x.jsx)(v.F,{children:t}):null,i.map((function(e){var t=e.key,i=e.value;return(0,x.jsx)(f.s,{role:"menuitemradio","aria-checked":t===r.key,CheckedIcon:n,onClick:function(){return a(t)},children:i},t)}))]})};const b="x-sortBox-sortDropdown",k="tPeL3BRKFCF4z2ibZpU7";var y=function(e){return e.isOpen?(0,x.jsx)(o.U,{iconSize:16,"aria-hidden":"true"}):(0,x.jsx)(c.i,{iconSize:16,"aria-hidden":"true"})},S=function(e){var n=e.heading,t=e.options,i=e.selected,o=e.onSelect,c=e.sortOrder,m=e.variant,h=void 0===m?"mesto":m,g=e.semanticColor,v=e.disabled,f=e.onClick,p=e.useSortIcon,S=(0,a.Z)(t,1)[0];return i||(i=S),(0,x.jsx)(u.y,{menu:(0,x.jsx)(C,{selected:i,options:t,onSelect:o,sortOrder:c,heading:n}),children:function(e,n,t){return(0,x.jsxs)("button",{className:l()(b,(0,r.Z)({},k,p)),onClick:function(e){v||(null==f||f(e),n(e))},ref:t,type:"button",children:[(0,x.jsx)(s.D,{semanticColor:g,variant:h,children:i.value}),p?(0,x.jsx)(d.w,{iconSize:16,"aria-hidden":"true"}):(0,x.jsx)(y,{isOpen:e})]})}})}},77495:(e,n,t)=>{t.d(n,{v:()=>y});t(47941),t(82526),t(57327),t(41539),t(38880),t(89554),t(54747),t(49337),t(33321),t(69070);var r=t(45987),a=t(4942),i=t(94184),l=t.n(i),o=t(72603),c=t(74257),s=t(38910),d=t(96206),u=t(51674),m=t(15852),h=t(45287),g=t(46128);const v="I3oc8sxg8Duq4kYUGnMo",f="LEZf9K5hG4hfCKfgr5Xo";var p=t(85893),x=["uri"];function C(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function b(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?C(Object(t),!0).forEach((function(n){(0,a.Z)(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):C(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}var k=function(e){return(0,p.jsx)(o.e,b({semanticColor:"textPositive"},e))},y=function(e){var n=e.uri,t=(0,r.Z)(e,x),i=(0,h.U)(n),o=i.isEnhanced,C=i.toggleIsEnhanced,y=(0,m.fU)(s.createDesktopEnhanceButtonEventFactory,{data:{uri:n}}),S=y.spec,j=y.logger,w=(0,p.jsx)(u._,{label:o?d.ag.get("web-player.enhance.button_aria_label_enhanced"):d.ag.get("web-player.enhance.button_aria_label_not_enhanced"),children:(0,p.jsx)(c.P,b(b({buttonSize:"sm",className:l()(v,(0,a.Z)({},f,o))},t),{},{iconLeading:o?k:void 0,onClick:function(){j.logInteraction(o?S.hitUnenhanceContext({contextToBeUnenhanced:n}):S.hitEnhanceContext({contextToBeEnhanced:n})),C()},children:o?d.ag.get("web-player.enhance.button_text_enhanced"):d.ag.get("web-player.enhance.button_text_not_enhanced")}))});return o?w:(0,p.jsx)(g.T,{id:"enhance-button",bodyText:d.ag.get("web-player.enhance.onboarding.enhance-playlist"),children:w})}},46128:(e,n,t)=>{t.d(n,{T:()=>v});var r=t(29439),a=t(67294),i=t(73935),l=t(55914),o=t(32667),c=t(73012),s=t(34011),d=t(32648),u=t(5229);const m="iW5kFTiudWn9ItsTvZmz",h="OfNgl_iK7pi63fAi8USM";var g=t(85893),v=function(e){var n,t,v,f,p,x,C,b,k,y=e.id,S=e.title,j=e.bodyText,w=e.buttonText,D=e.shouldScrollIntoView,O=e.children,E=(0,u.z)("onboarding-dismissed:".concat(y),!1),_=(0,r.Z)(E,2),N=_[0],A=_[1],T=(0,a.useContext)(d.VX).scrollNodeRef,I=(0,a.useState)(null),R=(0,r.Z)(I,2),L=R[0],P=R[1],B=(0,a.useState)(null),Q=(0,r.Z)(B,2),Z=Q[0],U=Q[1],M=(0,a.useRef)(!1);(0,a.useEffect)((function(){D&&Z&&!M.current&&(M.current=!0,Z.scrollIntoView({behavior:"smooth",block:"center"}))}),[D,Z]);var F=(0,a.useCallback)((function(){return A(!0)}),[A]);(0,a.useEffect)((function(){if(N)return function(){};var e=function(e){"Escape"===e.key&&F()},n=function(e){e.target instanceof Node&&(null==Z||!Z.contains(e.target))&&F()};return window.addEventListener("keydown",e,!0),window.addEventListener("click",n,!0),function(){window.removeEventListener("keydown",e,!0),window.removeEventListener("click",n,!0)}}),[N,F,Z]);var Y=null===(n=T.current)||void 0===n?void 0:n.getBoundingClientRect(),K=null==L?void 0:L.getBoundingClientRect();return(0,g.jsxs)(g.Fragment,{children:[(0,g.jsx)("span",{ref:P,children:O}),!N&&K&&(0,i.createPortal)((0,g.jsx)("div",{className:m,style:{top:(null!==(t=null==K?void 0:K.top)&&void 0!==t?t:0)-((null!==(v=null==Y?void 0:Y.top)&&void 0!==v?v:0)-(null!==(f=null===(p=T.current)||void 0===p?void 0:p.scrollTop)&&void 0!==f?f:0)),left:(null!==(x=null==K?void 0:K.left)&&void 0!==x?x:0)-((null!==(C=null==Y?void 0:Y.left)&&void 0!==C?C:0)-(null!==(b=null===(k=T.current)||void 0===k?void 0:k.scrollLeft)&&void 0!==b?b:0)),width:null==K?void 0:K.width,height:null==K?void 0:K.height},ref:U,children:(0,g.jsxs)(l.J,{popoverTitle:S,arrow:l.J.bottom,colorSet:"announcement",className:h,children:[(0,g.jsx)(o.D,{as:"p",paddingBottom:w&&c.g4V,children:j}),w&&(0,g.jsx)(s.D,{buttonSize:"sm",colorSet:"invertedLight",onClick:F,children:w})]})}),T.current||document.body)]})}},61412:(e,n,t)=>{t.d(n,{v:()=>r.v});var r=t(77495)},12498:(e,n,t)=>{t.d(n,{v:()=>r.v});var r=t(27333)},40786:(e,n,t)=>{t.d(n,{s:()=>S});t(68309),t(82526),t(41817),t(91058);var r=t(67294),a=t(87577),i=t(96206),l=t(35410),o=t(20701),c=t(60289),s=t(59482),d=t(72907),u=t(61348),m=t(55120),h=t(77834),g=t(24172),v=t(49207),f=t(18261),p=t(51802),x=t(46457);t(21249),t(57327),t(41539);function C(e){return e.user||null}function b(e){return!!e}function k(e){var n=arguments.length>1&&void 0!==arguments[1]&&arguments[1];return{id:e.username,uri:e.uri,name:e.username,displayName:e.displayName||void 0,images:e.images,isMadeFor:n}}var y=t(85893),S=function(e){var n,t=e.metadata,S=e.isPlaying,j=e.togglePlay,w=e.backgroundColor,D=e.spec,O=e.specLikedSongs,E=t.uri,_=t.name,N=t.description,A=void 0===N?"":N,T=t.images,I=t.totalLength,R=t.totalLikes,L=t.duration,P=t.owner,B=t.isOwnedBySelf,Q=void 0!==B&&B,Z=t.isCollaborative,U=void 0!==Z&&Z,M=t.formatListData,F=t.madeFor,Y=void 0===F?null:F,K=t.collaborators,X=(null==M?void 0:M.attributes)||{},z=X.header_image_url_desktop||X.image_url||null,W=null!==z?[{url:z,width:null,height:null}]:[],G=(0,a.W6)(v.bM),V=(0,p.$)(),q=(0,r.useMemo)((function(){return function(e,n){var t=arguments.length>2&&void 0!==arguments[2]?arguments[2]:[],r=arguments.length>3?arguments[3]:void 0;return e?[k(e,!0)]:t.length>1&&r?t.map(C).filter(b).map((function(e){return k(e)})):[k(n)]}(Y,P,null==K?void 0:K.items,G)}),[Y,P,null==K?void 0:K.items,G]),J=(0,r.useContext)(g.zy),H=(0,r.useContext)(x.S7),$=(0,r.useCallback)((function(){if(D){var e=D.ownerFactory().hitUiReveal();V.logInteraction(e)}H({type:"open",uri:E})}),[H,E,D,V]),ee=(0,r.useCallback)((function(e){if(D){var n=null==D?void 0:D.descriptionTextFactory().hitUiReveal();V.logInteraction(n)}J({type:"open",playlistDetails:{name:_,description:A,image:T[0],uri:E},focusedElement:e})}),[D,J,_,A,T,E,V]),ne=(0,r.useCallback)((function(){if(D){var e=D.coverArtFactory().hitUiReveal();V.logInteraction(e)}J({type:"openWithImagePicker",playlistDetails:{name:_,description:A,image:T[0],uri:E}})}),[J,_,A,T,E,V,D]),te=(0,r.useCallback)((function(e,n){if(D){var t=D.ownerFactory().hitUiNavigate({destination:n.creator.uri});V.logInteraction(t)}if(O){var r=O.ownerFactory().hitUiNavigate({destination:n.creator.uri});V.logInteraction(r)}}),[V,D,O]),re=G&&t.permissions?null!==(n=t.permissions)&&void 0!==n&&n.isPrivate?i.ag.get("private_playlist"):i.ag.get("public_playlist"):U?i.ag.get("sidebar.collaborative_playlist"):i.ag.get("playlist");return(0,y.jsxs)(c.gF,{backgroundColor:w,backgroundImages:W,children:[(0,y.jsxs)(s.W,{children:[(0,y.jsx)(m.$,{size:"md",onClick:j,isPlaying:S,uri:E}),(0,y.jsx)(d.i,{text:_,dragUri:E,dragLabel:_})]}),z?null:(0,y.jsx)(f._,{menu:(0,y.jsx)(l.X,{uri:E}),children:(0,y.jsx)("div",{className:h.Z.playlistImageContainer,children:(0,y.jsx)(o.T,{canEdit:Q,name:_,images:T,onClick:ne,placeholderType:"playlist",dragUri:E})})}),(0,y.jsxs)(c.sP,{children:[(0,y.jsx)(c.dy,{small:!0,uppercase:!0,children:re}),(0,y.jsx)(f._,{menu:(0,y.jsx)(l.X,{uri:E}),children:(0,y.jsx)(c.xd,{canEdit:Q,onClick:function(){if(D){var e=D.titleFactory().hitUiReveal();V.logInteraction(e)}ee(g.w.TITLE)},dragUri:E,dragLabel:_,ariaLabel:i.ag.get("playlist.edit-details.button",_),children:_})}),A&&(0,y.jsx)(c.dy,{bold:!1,gray:!0,canEdit:Q,onClick:function(e){return function(e){e.target.href||ee(g.w.DESCRIPTION)}(e)},children:(0,y.jsx)(u.w,{html:A,onTimeStampClick:function(){}})}),(0,y.jsx)(c.QS,{creators:q,onPiledCreatorsClick:$,onCreatorClick:te,totalTracks:I,totalLikes:null!=R?R:0,durationMilliseconds:null==L?void 0:L.milliseconds,isEstimatedDuration:null==L?void 0:L.isEstimate,newEntries:parseInt(X.new_entries_count||"0",10)})]})]})}},40080:(e,n,t)=>{t.d(n,{D:()=>a});var r=t(67294);function a(e){var n=(0,r.useRef)();return(0,r.useEffect)((function(){n.current=e}),[e]),n.current}},77834:(e,n,t)=>{t.d(n,{Z:()=>r});const r={xs:"(min-width: 0px)",xsOnly:"(min-width: 0px) and (max-width: 767px)",sm:"(min-width: 768px)",smOnly:"(min-width: 768px) and (max-width: 1023px)",md:"(min-width: 1024px)",mdOnly:"(min-width: 1024px) and (max-width: 1279px)",lg:"(min-width: 1280px)",lgOnly:"(min-width: 1280px) and (max-width: 1919px)",xl:"(min-width: 1920px)",playlist:"playlist-playlist-playlist",searchBoxContainer:"playlist-playlist-searchBoxContainer",recommendedTrackList:"playlist-playlist-recommendedTrackList",playlistContent:"playlist-playlist-playlistContent",playlistDescription:"playlist-playlist-playlistDescription",top:"playlist-playlist-top",header:"playlist-playlist-header",subtitle:"playlist-playlist-subtitle",refreshButton:"plyalist-playlist-refreshButton",playlistImageContainer:"playlist-playlist-playlistImageContainer",playlistInlineCurationSection:"playlist-playlist-playlistInlineCurationSection",playlistInlineCurationTitle:"playlist-playlist-playlistInlineCurationTitle",playlistInlineCurationWrapper:"playlist-playlist-playlistInlineCurationWrapper",playlistInlineCurationCloseButton:"playlist-playlist-playlistInlineCurationCloseButton",playlistInlineCurationBackButton:"playlist-playlist-playlistInlineCurationBackButton",artistResultListTitle:"playlist-playlist-artistResultListTitle",seeMore:"playlist-playlist-seeMore",emptyStateContainer:"playlist-playlist-emptyStateContainer",searchResultListContainer:"playlist-playlist-searchResultListContainer",emptySearchTermContainer:"playlist-playlist-emptySearchTermContainer",icon:"playlist-playlist-icon"}}}]);
//# sourceMappingURL=2597.js.map