"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[708],{31469:(e,i,t)=>{t.d(i,{n:()=>A});t(10817);var s=t(59496),r=t(84875),a=t.n(r),n=t(86695),l=t(88778),c=t(58084),d=t(38314),o=t(25007),u=t(27002),m=t(31928),x=t(36682);var h=t(73414),p=t(49353),j=t(39625),g=t(20731);const y="main-topBar-contentArea",f="muYk5XIwKmqR9iNibk_f",v="queue-tabBar-headerItem",k="queue-tabBar-moreButton",b="queue-tabBar-moreButtonActive",C="yxf_6IsQEmHjijEBUMTP",E="queue-tabBar-active",N="queue-tabBar-headerItemLink",w="queue-tabBar-header",R="queue-tabBar-chevron";var T=t(4637);const U=({items:e,activeItemId:i})=>(0,T.jsx)(j.v,{children:e.map((e=>e.disabled?(0,T.jsx)(g.s,{disabled:!0,role:"menuitemradio",className:C,onClick:e.handleClick,children:e.title},e.uri):(0,T.jsx)(g.s,{role:"menuitemradio",to:e.to,exact:!0,"aria-checked":e.itemId===i,className:C,activeClassName:E,onClick:e.handleClick,children:e.title},e.uri)))}),A=(0,s.memo)((function({isCentered:e,links:i,landmarkLabel:t,className:r}){const j=(0,s.useRef)(null),[g,C]=(0,s.useState)([]),[A,I]=(0,s.useState)(0),[S,O]=(0,s.useState)([]),D=function(){const[e,i]=(0,s.useState)(window.innerWidth),{scrollNodeChildRef:t}=(0,s.useContext)(m.VX),r=(0,u.y1)((e=>{e?.width&&i(e.width)}),250);return(0,x.y)({refOrElement:t,observeOnly:"width",onResize:r}),e}()??1/0,{pathname:M}=(0,n.TH)(),P=i.find((e=>e.to===M));return(0,s.useEffect)((()=>{j.current&&I(j.current.clientWidth)}),[D]),(0,s.useEffect)((()=>{if(!j.current)return;const e=Array.from(j.current.children).map((e=>e.clientWidth));C(e)}),[i]),(0,s.useEffect)((()=>{if(!j.current)return;if(g.slice(0,-1).reduce(((e,i)=>e+i),0)<=A)return void O([]);const e=g.reduce(((e,i)=>e>i?e:i),0),i=[];let t=e;g.forEach(((e,s)=>{A>=t+e?t+=e:i.push(s)})),O(i)}),[A,g]),(0,T.jsx)("nav",{className:a()(r,y),"aria-label":t,children:(0,T.jsxs)("ul",{className:e?f:w,ref:j,children:[i.filter(((e,i)=>!S.includes(i))).map((e=>(e?.render??(e=>e))((0,T.jsx)("li",{className:v,children:e.disabled?(0,T.jsx)("div",{className:N,children:(0,T.jsx)(l.D,{variant:"mestoBold",children:e.title})}):(0,T.jsx)(p.O,{exact:!0,className:N,activeClassName:E,to:e.to,onClick:e.handleClick,children:(0,T.jsx)(l.D,{variant:"mestoBold",children:e.title})})},e.to)))),S.length||0===g.length?(0,T.jsx)("li",{className:v,children:(0,T.jsx)(h.xV,{renderInline:!0,menu:(0,T.jsx)(U,{items:i.filter(((e,i)=>S.includes(i))),activeItemId:P?.itemId}),children:(e,i,t)=>(0,T.jsxs)("button",{className:a()(k,{[b]:P}),type:"button",onClick:i,ref:t,children:[(0,T.jsx)(l.D,{variant:"mestoBold",children:P?P.title:o.ag.get("more")}),e?(0,T.jsx)(c.U,{iconSize:16,className:R,"aria-hidden":"true"}):(0,T.jsx)(d.i,{iconSize:16,className:R,"aria-hidden":"true"})]})})}):null]})})}))},32195:(e,i,t)=>{t.d(i,{I:()=>x});var s=t(63678),r=t(59496),a=t(25007),n=t(31469),l=t(46213),c=t(85037),d=t(33269);const o="queue-tabBar-nav";var u=t(4637);const m=()=>{const e=(0,d.Y)(),i=(0,r.useCallback)((e=>(0,u.jsx)(c.v,{placement:"bottomEnd",arrow:"topStart",title:a.ag.get("pick-and-shuffle.upsell.title.queue"),children:e})),[]),t=(0,r.useMemo)((()=>[{title:a.ag.get("playback-control.queue"),itemId:"queue",to:"/queue",uri:"spotify:app:queue",render:i,disabled:e},{title:a.ag.get("view.recently-played"),itemId:"history",to:"/history",uri:"spotify:app:history"}]),[e,i]);return(0,u.jsx)(l.w,{children:(0,u.jsx)(n.n,{className:o,links:t})})},x=({children:e})=>{const i=(0,s.nF)();return(0,u.jsxs)("section",{className:"contentSpacing",children:[e,i&&(0,u.jsx)(m,{})]})}},52555:(e,i,t)=>{t.r(i),t.d(i,{default:()=>F});var s=t(63678),r=t(36026),a=t(88778),n=t(25007),l=t(65379),c=t(61366),d=t(4637);const o=()=>(0,d.jsxs)("div",{className:c.Z.emptyContainer,children:[(0,d.jsx)(l.Y,{iconSize:64,"aria-hidden":"true"}),(0,d.jsx)(a.D,{as:"h1",variant:"alto",semanticColor:"textBase",className:c.Z.emptyContainerTitle,children:n.ag.get("history.empty-title")}),(0,d.jsx)("p",{children:n.ag.get("history.empty-description")})]});var u=t(59496),m=t(45476),x=t(23390),h=t(29009),p=t(78034),j=t(92910),g=t(46958),y=t(57559),f=t(88585),v=t.n(f),k=t(43181),b=t(71748),C=t(34657),E=t(42721),N=t(74313),w=t(59950),R=t(38205),T=t(57915),U=t(45462),A=t(86364),I=t(31269),S=t(98082),O=t(43229),D=t(61295),M=t(17754);const P=u.memo((function({uri:e,name:i,duration_ms:t,index:s,imgUrl:r,artists:a,album:l,isExplicit:c,isMOGEFRestricted:o,type:u}){const{isActive:m,isPlaying:x,triggerPlay:p,togglePlay:g}=(0,S.n)({uri:e},{featureIdentifier:"history"}),y=u===j.p.TRACK,f=u===j.p.EPISODE,P=u===j.p.CHAPTER,_=(0,I._)(e),B=(0,M.k)(e),{badges:G,hasBadges:L}=(0,O.r)({downloadAvailability:_,isExplicit:c,isMOGEFRestricted:o}),Z=a?.map((e=>e.name)).join(n.ag.getSeparator())||"";let F;return f?F=(0,d.jsx)(k.k,{uri:e,contextUri:e,showUri:l.uri}):P?F=(0,d.jsx)(D.r,{uri:e,contextUri:e,showUri:l.uri}):y&&v().isLocalTrack(e)?F=(0,d.jsx)(b.N,{uri:e,contextUri:e}):y&&(F=(0,d.jsx)(C.$,{uri:e,contextUri:e,albumUri:l.uri,artists:a})),(0,d.jsx)(h.ZP,{value:"row",index:s,children:(0,d.jsx)(R._,{menu:F,children:(0,d.jsxs)(w.c,{uri:e,contextUri:e,index:s,ariaRowIndex:s,onTriggerPlay:()=>{p()},isActive:m,isPlayable:B,ageRestricted:o,dragMetadata:{name:i,createdBy:Z},children:[(0,d.jsxs)(E.vZ,{ariaColIndex:0,children:[(0,d.jsx)(E.VG,{uri:e,src:r,isPlaying:x,isActive:m,isLocked:!1,onClick:()=>{g()},isEpisode:v().isEpisode(e),playAriaLabel:n.ag.get("tracklist.a11y.play",i,Z)}),(0,d.jsxs)(E.vm,{children:[(0,d.jsx)(E.Wh,{titleText:i,children:i}),L&&(0,d.jsxs)(E.g3,{children:[G.download&&(0,d.jsx)(T.G,{size:16}),G.explicit&&(0,d.jsx)(U.N,{}),G.nineteen&&(0,d.jsx)(A.X,{className:N.Z.nineteen,size:16})]}),(0,d.jsx)(E.K9,{children:v().isTrack(e)?(0,d.jsx)(E.T6,{artists:a}):a[0]?.name??""})]})]}),(0,d.jsx)(E.UA,{ariaColIndex:2,children:(0,d.jsx)(E.BM,{nonInteractive:v().isLocalTrack(e),uri:l.uri,name:l.name,creatorUri:a?.[0]?.uri,children:l.name})}),(0,d.jsxs)(E.mU,{ariaColIndex:1,children:[!v().isLocalTrack(e)&&!P&&(0,d.jsx)(E.qS,{uri:e,type:u}),(0,d.jsx)(E.A$,{duration:t}),(0,d.jsx)(E.Zv,{menu:F,label:n.ag.get("more.label.track",i,Z)})]})]})})})}),((e,i)=>e.uri===i.uri)),_=u.memo((function({items:e}){const i=(0,u.useCallback)(((e,i)=>{const t=(0,y.X)(e.images??[],{desiredSize:40});return(0,p.G_)(e)?e.isLocal?(0,d.jsx)(P,{index:i,uri:e.uri,name:e.name,duration_ms:e.duration.milliseconds,imgUrl:t?.url||"",album:e.album,artists:e.artists,isExplicit:e.isExplicit??!1,isMOGEFRestricted:e.is19PlusOnly??!1,type:j.p.TRACK},i+e.uri):(0,d.jsx)(P,{index:i,uri:(0,x.$)(e),name:e.name,duration_ms:e.duration.milliseconds,imgUrl:t?.url||"",album:e.album,artists:e.artists,isExplicit:e.isExplicit??!1,isMOGEFRestricted:e.is19PlusOnly??!1,type:j.p.TRACK},i+e.uri):(0,p.iw)(e)?(0,d.jsx)(P,{index:i,uri:e.uri,name:e.name,duration_ms:e.duration.milliseconds,imgUrl:t?.url||"",album:e.show,artists:[],isExplicit:!1,isMOGEFRestricted:!1,type:j.p.EPISODE},i+e.uri):(0,p.G7)(e)?(0,d.jsx)(P,{index:i,uri:e.uri,name:e.name,duration_ms:e.duration.milliseconds,imgUrl:t?.url||"",album:e.book,artists:[],isExplicit:!1,isMOGEFRestricted:!1,type:j.p.CHAPTER},i+e.uri):((0,p.k6)(e)||(0,p.RB)(e)||(0,g._)(e),(0,d.jsx)(m.hU,{height:`${m.dN}px`}))}),[]),t=(0,u.useMemo)((()=>[m.QD.TITLE,m.QD.ALBUM_OR_PODCAST,m.QD.DURATION]),[]),s=(0,u.useCallback)((e=>e.uri),[]);return(0,d.jsx)(d.Fragment,{children:(0,d.jsx)(h.ZP,{value:"play-history-tracklist",children:(0,d.jsx)(m.Pv,{ariaLabel:"play-history",hasHeaderRow:!0,columns:t,renderRow:i,resolveUri:s,tracks:e,nrTracks:e.length,rowPlaceholder:m.hU,limit:50})})})})),B="dt3fysZYdQ6hhWfpmjAu",G="n6LsTkKvpO88xeRyRTdw",L=()=>{const e=(0,s.U5)();return e&&e.items.length>0?(0,d.jsxs)("div",{className:B,children:[(0,d.jsx)(a.D,{as:"h1",variant:"canon",semanticColor:"textBase",className:G,children:n.ag.get("view.recently-played")}),(0,d.jsx)(_,{items:e.items})]}):(0,d.jsx)(o,{})};var Z=t(32195);const F=()=>(0,s.nF)()?(0,d.jsx)(Z.I,{children:(0,d.jsx)(L,{})}):(0,d.jsx)(r.w,{to:"/"})},23390:(e,i,t)=>{t.d(i,{$:()=>s});const s=e=>e?.linked_from?.uri||e.uri},61366:(e,i,t)=>{t.d(i,{Z:()=>s});const s={emptyContainer:"gTvMl6pwfRD9PobMSB5x",emptyContainerTitle:"hNAQG0TAe2WFYyf_iZEB",findSomething:"Zhzrb2k9nQRActS2lp4U"}}}]);
//# sourceMappingURL=xpui-routes-play-history-page.js.map