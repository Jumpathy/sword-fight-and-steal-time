coroutine.wrap(function()
	return(function(i,l,e,e)local M=string.byte;local e=table.getn or function(e)return#e end;local t=string.sub;local E=table.insert;local h=l;local B=getfenv or function()return _ENV end;local D=setmetatable;local a=unpack or table.unpack;local J=string.char;local r=pairs;local c=tonumber;local I=select;local s={}for e=0,255 do s[e]=J(e)end;local function G(d)local l,n,o="","",{}local a=256;local e=1;local function f()local l=c(t(d,e,e),36)e=e+1;local n=c(t(d,e,e+l-1),36)e=e+l;return n end;l=J(f())o[1]=l;while e<#d do local e=f()if s[e]then n=s[e]else n=l..t(l,1,1)end;s[a]=l..t(n,1,1)o[#o+1],l,a=n,n,a+1 end;return h(o)end;local f=G('23E23F23E23D23723E27925M25C26725O25W25V25O26T27023D23I27923E26626525O25V22Y23E22P22P21E21H22P21G21L21G21E21D22Q21G21J22U22Q21C27527923F23127M23D23C27M25C25N23D23427M26M25M26126O25G25X25V26Q26Y26Y23D21M27M26G26L26M26F26C26926A25V25S25X25Y26726426126226326026526625Z25W25T25U1Z1W2111S1H1I1J1G1D1E1714191A1B1821H21I21B2181X1Y29N21P21Q21J27Z23523A23B181D2A029Y1E1U1423D23627M26L25C25F25Z26F25I25L26V23D23527M27B25C25Q25W25L25O26W26W26J26W23D23J27M26125Q25G29L2AO27M26926225C25E25R25K25O27323D22Z27M26Z25M2652BP25G25G26N27026Z25Q26F27226D26S26K26K27K27M25Q25Q25C25I2AZ2BK26326128T25E25Z26L26O2702BB27827926I25J25O25T25C2BH27226J23D23A27M25N25Q26625I24724325C26T26Y26O26X26U23D23H27M26X25F25O26228R25Y2D327M2722BG2AU25K25Z26026P26U26P2AY2D427928N25F25I25V25I25T27226625M25W25Z2BJ27A25C25C25V25V25E25Y26G2DI27M26325M26425Y25K25X25C2DR27926Y28O26A28S25Z26Q26Z26I26H2DH2B027926D2B325E25P26V25L26Y26826Y26N2EY23E28N2612F225V2F42F62F82FM2D62D82DA25D2722DE2DG23D23G27M25O26125K25P25X25W2BC2BE25O25O25R25P2AP28B2DJ27923D27M27628G27924426Q28F27M26Q26P2CC27925Q26426025D23D28A23E23R23D23027M23W25N23S25J23O25F24A25A27124G25426V24U24Y26P25024S26J24Y24M26D2542G327M29E26725M25R25C2GP2792BD2H327M2482H42GN21M2I927923U25H2GX23E25R25I25F25J2IC28E2H42492GM27M2IM22Q21M2I62GQ2IM23U21X2GN22G2GN22427924P23E2I322K22E2742I42JA27823I22J2GN2BD27522W2132742752GK2791R28B2J627M2JJ2JL23E2JN23E2GI2I327922I28B28G28G27L2GN2K52GN27M2K42JR2K12792K323E28L22W28E2JX2JS27M27L28L2792KH2JB2IQ23E2K72GM2K128A21D2792DJ2H422Y22O2792AP28G2G42GN2L42KJ2KC23E2782G428L27S27927828G2CT27M2LH2LB2K82AP2AP27823827M2BD22R2JA2AP2JE2GN2LU2752LX27M22V2JA2JT23F2AP2H423G2172L323E2M32H42M12792MD2KS2JF27M22S2M42JK2M623E2L627921I2JQ2DJ2LW1O2GL23E2392JA23E2JP2JA2JZ21F2GN2H423F23F2LJ2IV23E2I82K82IR2NE23E2IB2NE2IY2IM22I2IU2GN2IG25M2CW25T23D2KR26226225R2HW2792HY2I025C2GN2LA23E21E2JQ2K82J323E2J52J72232JQ2G42752BD2MF2MP2MM2JU2MQ2N12JQ2I32JT2N32JS2JK2JR2K72OQ2GM2BD2KO2OT27L2K723I1L2KD23E2L227522I22B2742MQ2GI2KX2KJ2OY2792PE2782PG23E122792G42LL22K2OD23F2G42KH2752M02MJ2KO2JA2OI28D27522Y28A2G42BD2BD22Y21N2PN2762OJ2M92QA2Q12KL2PX23E2QF2OI22Q2OK2OJ2JZ2KP2PV2OJ23I2MW2JR2B02JI1E2742LI27M22I192QY2JR2JW2QB2IM2JR2KR2GN2JZ2NG2N72H827M2L62OB2KK2JU2JN2KC2N82PZ2K82RB2QP2GM2R92KL2K82QP2BD2RB2MX2OX23E2QP27L2R72M02JR2NE2H42RL2ME2S028B2RZ2PN21W2792K72QQ23E21T2NG2792PM2RN28G2P92JU2S42M52GM2MQ23C2292SF2N02SL2JQ27L2GP2N22752N42N62IR2N928E2LF23E2HA2HC2HE2HG2HI2HK2HM2HO2IM2362IU2K724924F24D2432IX21X2GT2GQ2422IG2GZ2H12NB2442NB2H62RA2IR2NA2H42482IG25N25Y2612CH2T62NE2IU2IO2NL2NI2K82NK2SK2IX25H2GN22P2GN2112J42S52SA2JU2KR2RL2I32RB2KE28G2KP2QB2MQ2V327L2JN2V32BD2LJ2KT23E2LZ2PH2KY2SY2L12MB27L2OM2KJ28G2AP2LA2LC2JV23E2TA2JD2LM2GN2LL2LJ2MB2LP23E2LR2MB2PU2KJ2OI2W42OI2H82JI2MN2M72RF2MA2KJ2W92QG2GN2WG2Q02OK2MO2PK2MS2JA2MU2KS2QT2GM2WC2ON2OR27M2N52NF28B23F2JN2IS2UG2I72R72762NU2NW2R92R72UJ2GN2IY2GN22T2GN2O62SY27M2O92RH27922K2212OE2JA2PW2GN2OF2S02MN2OG2GN2T32UU2OQ2752KR2OQ28G2V82OT2GM2H42OQ2V72KL2P42JR2QL2P82PA2PS2RT23E2PE2AP2PK2PI23E2PK2SM2PO2JR2J82PB23E2332OR2OI2YX2Q22Q42JA2Q72Q92QC2QC2282QA2WG2XS27M2WG2OQ2G42R92QP2JA2G42QS2P52QV2792UQ2UU2K027823F2KE27L2LA2S22VR2LA2JH2VR2U42PK2K92SK2WZ2742QL2XK2UT2I32SP2RM2QA2SS2KJ2KD2SW2KS2NE1U2T02JR2QP28G2RS2JQ2T423E2S82ZI2UV23F2Y82RF2SE310I2QQ28A2SJ2SK21R310L2V02QB2PY2742GM2LJ2S12YP2RI23F2BD2R52P52PK2XI2RS22I21Q2RY2KB2KI2GM2K72P5310O2K82QQ2RB310R2UM2T72JN2EG23E2HY25E25X25E25E26A2IG26R25F25G2H22PG1M1V1C1V1M312326I2EI2EK2EM2EO2E323E2FW2D92DB2DD2DF2DH2JN25P25Y25F25E25O25Q25I2IM22G28Y27M2W22791I2O72NG2XM310S2X02Z32RO2SY2UY2JR2SO2K22OU2K8310P2YJ2JR22228B2ZW2G4313W2SX2GM2R52KA2S631042X631052N82FA2762GI23E2B2312P2EN2TX2CF2CH2X82NX2KN2FN28O28Q28S28U28W314A2692CK2CM2CO2CQ26W2TS2GC2792BF2BH25U2NY23E26525Y26525I25Q2H2314C26525C29I25V25Q25N27J314M26B27026A26L26C25L25I26S27128W312S312U2DA2DC2G126U2GN22L2GN214313F2NE313H310N3100313S31042ZT310I2LY2N02ZO2R522I21B2742DJ2DJ314A2MB31022VG2KE2QP2LO2NG2VQ2NE2L8313P274316V2GM2V328L2V527M2B02VL2MB2B02RB2VY313I2742782782B02QP28L317D27931782NG28L316P2LK31032L72KJ317D2JM2KJ23G21U2P52XU2K42QH2XU27T2P52O321G2R328G2JI2SB2UU2RL2RR310I2RV311E2NE2RZ3170310W2QB314M2JB2R72SC313L2SK2RX311W2T72KR23F21Z23424T2611A21Z24O2TT2V326K25N25G25Z2682BH26Q26N27226H26Y27226X25D26A26C26I315626K25D25O25D25P25E2VW2GN1K3104318V2RB313H310T2P52V3318A2RC2JR2P8313J2MX2T62SH318V2IR3122313C2FO26F25G25W25I27226V26Z27027126D26C2NT27M2682642CB2PG31532BI2LJ26J25C25L26226K25K25V2D12FM31B331B526P25K25Y26Q26L26U26Q27131BB31B426226V25E25L26S26Y26U26H319O314C31BC26226E29I26S2GN22H2GN1V3109311F2Y22R0313Q31672R831A72MX311T23E2ML2YG2YV2RW2XV31712OJ27M2YR2VM2MP2Z82OJ22U2XR2MI2GN31CV31CJ2YI31CL2M52YM2GN31CQ2L823G31CT2G431CZ2PZ2QH31DB310B2Q5310M2WB316F2SZ2OJ31D72WE2G42WG2SF2QH2WJ31DD2JA31DF311E2V231DI2JW31D62JR31D82QA31DB2ZB27931DB2OI31CI27922D2QA2I92N22G42I3317Y2XQ310R2OI318431EB2XJ2JO2OO2GN2WY313F2752782TU312T26731EV2662642IG315A25Q25K2FM2FO2FQ2FS2F72DH2K72CE2CG31EV25F31EX2MQ26225O2HZ25T25V2IG2662DU2IG2622662672EF2K725G25Q26128J2BU2792BW2BY25K2C02C22C42C62C82CA31EV28I28K27M26N25I26725I26Q2CN26L27026L2NB25P31GD2E4314O28R28T28V315626X25Q31GH25R31FM2LJ2DT25D25K26Q25Z25C27231BL2LJ26B2BM25V31BE25U2D12GN22K2J231C72KO2QX28A314C2QI2T62L531CT31EC31DC2XT31HV27M22N316H2SK22I1C2XJ23B313L318Q2LS310V2KM31CA2742P12LM318H2PG2RL2Q62MY310V316O2NG311H311Q27431II27L2QP2DJ313C2JG316B2K631032LF318M311S2K82T127M31IZ2GM2D431CG27L2UX313X310I2BU31J5313R31IX31JA31IC318G2VS318C2ZJ31J231DJ318H2RK28B31II2TA2SX2KE31JE2S42U4313T2T631CG2SH31ER31EN2Y22LJ27B27D27F27H27J2K727O27Q2GN2JW1A31HL310V313F2RL2U42UE316D2ZP2NF2S32GN2182GN23231KI2ZH2VV317E2I92V2313Q31HP313L318L2GN2LR316A2RE2NG2KE31KL313B310V28G316R310331L12JU31G031LE31KY313N2VN31KZ316E31HR31KP311X310V311B31IB31J0310M31JR23E31I5318J31DW31KZ318F22X31M42QB31KV318H31I731D231JB2LJ2RL31ID31LI2YI31M131JN31EF31KZ31ID31M631MF31JJ2QP318431IK31LM2GJ2VR31MH278318O27M2DJ2LL2RL316N31IJ31KF310F31JN31CC31CG318H2KR23G310Z2MQ2SH21031IV27922Y2W927L2YX2G431ND31HU31NG31NI2VS31NL23E2D431NO31NE31A82S531NH313U23E31O1318631NT31JI27S31NX2QA310X28A31O431DJ31NP2VR2ZW31OC31KN22W1Z31CN31ME28B316V31MH28L31MJ317T28L318L316V31MO31OO2KJ2B02RL316V31L728B28L311I2KJ31OU2J6310H2PJ310Y2793175313K31O3310431OD2OM31OD2R931OD31HP31OD311C16274317N2NE2D4318U31I531P62LR31MZ2792D431IU1G317M2JR31I52OI2152M431HN27S28D2SD2792BU2KZ2N031OD2MZ27M1Q31NJ31NZ2MC27931IU2MP317Z23E2B0318831EJ2QH31QV27931K32I92JW2XL2Y031HN31KK2D431L031P931CC23E31M631LH27922631AC31QZ31KN23E');local h=(bit or bit32)and(bit or bit32).bxor or function(e,l)local n,o=1,0 while e>0 and l>0 do local a,d=e%2,l%2 if a~=d then o=o+n end e,l,n=(e-a)/2,(l-d)/2,n*2 end if e<l then e=l end while e>0 do local l=e%2 if l>0 then o=o+n end e,n=(e-l)/2,n*2 end return o end local function o(l,e,n)if n then local e=(l/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(l%(e+e)>=e)and 1 or 0;end;end;local e=1;local K=0;local function n()local l,n,o,d=M(f,e,e+i);l=h(l,122)n=h(n,122)o=h(o,122)d=h(d,122)e=e+4;return(d*16777216)+(o*65536)+(n*256)+l;end;local function c()local l=h(M(f,e,e),122);e=e+1;return l;end;local function d()local l,n=M(f,e,e+2);l=h(l,122)n=h(n,122)e=e+2;return(n*256)+l;end;local function N(...)return{...},I('#',...)end local function Q()local G={};local l={};local J={};local r={[7]=nil,[9]=nil,[6]=J,[8]={},[5]=G,[i]=l,};local l={}local a={}for r=1,c()==0 and d()*2 or n()do local l=c();while 2 do if(l==1)then local n,e=n(),n();local d,n,e,o=1,(o(e,1,20)*(2^32))+n,o(e,21,31),((-1)^o(e,32));if e==0 then if n==0 then l=o*0 break;else e=1;d=0;end;elseif(e==2047)then l=(o*((n==0 and 1 or 0)/0))break;end;l=(o*(2^(e-1023)))*(d+(n/(2^52)));break;end if(l==2)then local n=n();l=t(f,e,e+n-1);e=e+n;break;end if(l==0)then l=(c()~=0);break;end if(l==i)then local o,d,n='',n();if(d==0)then l=o;break;end;n=t(f,e,e+d-1);n={M(n,1,#n)}e=e+d;for e=1,#n do o=o..s[h(n[e],122)]end l=o break;end if(l==0)then l=(c()~=0);break;end l=nil break;end a[r]=l;end;if K<1 then K=1 local l=d()r[4]=t(f,e,e+l-1)e=e+l end for e=1,n()do J[e-1]=Q();end;for s=1,n()do local e=c();if(o(e,1,1)==0)then local t=o(e,4,6);local J,f,h,c=d(),c()==1,d(),{};local l=o(e,2,i);local e={[7]=h,[4]=J,[8]=nil,[1]=f,};if(l==1)then e[1]=n()end if(l==2)then e[1]=n()-65536 end if(l==0)then e[1],e[8]=d(),d()end if(l==i)then e[1],e[8]=n()-65536,d()end if(o(t,1,1)==1)then c[7]=7 e[7]=a[e[7]]end if(o(t,i,i)==1)then c[8]=8 e[8]=a[e[8]]end if(o(t,2,2)==1)then c[1]=1 e[1]=a[e[1]]end if f then E(r[8],e)e[2]=c end G[s]=e;end end;r[7]=c();return r;end;local function E(e,s,f,l)local l=e[9];local G=e[8];local Q=0;local l=e[7];local n={}local t=e[6];local e=e[5];return function(...)local o=e;local c=-1;local d={...};local n={};local K=I('#',...)-1;local M=N local N={};local L=t;local t=l;local l=1;local I={};for e=0,K do if(e>=t)then N[e-t]=d[e+1];else n[e]=d[e+1];end;end;local d;local e=K-t+1 local e;while true do e=o[l];d=e[4];if Q>0 then n[e[7]]=e[1];end if d<=61 then if d<=30 then if d<=14 then if d<=6 then if d<=2 then if d<=0 then local l=e[7]local d={n[l](a(n,l+1,c))};local o=0;for e=l,e[8]do o=o+1;n[e]=d[o];end elseif d==1 then n[e[7]]=e[1]-n[e[8]];else n[e[7]]=n[e[1]]+n[e[8]];end;elseif d<=4 then if d>i then n[e[7]][e[1]]=e[8];else n[e[7]]={};end;elseif d>5 then local d;local M;local c;local I,t,i,K;for n,l in r(G)do for o,n in r(l[2])do I,t,i,K={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#I do t,i=t..J(h(I[e],i)),(i+K)%256 end l[n],l[2]=t,{};end end;l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];c=e[1];M=n[c]for e=c+1,e[8]do M=M..n[e];end;n[e[7]]=M;l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7];c=n[e[1]];n[d+1]=c;n[d]=c[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];else local e=e[7]local o,l=M(n[e](n[e+1]))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;end;elseif d<=10 then if d<=8 then if d==7 then n[e[7]][e[1]]=n[e[8]];else local f;local c;local t;local d;n[e[7]]=s[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=n[e[1]]-e[8];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7];c=n[d]f=n[d+2];if(f>0)then if(c>n[d+1])then l=e[1];else n[d+i]=c;end elseif(c<n[d+1])then l=e[1];else n[d+i]=c;end end;elseif d>9 then n[e[7]]=n[e[1]]+e[8];else local t;local d;d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]+e[8];l=l+1;e=o[l];n[e[7]]=n[e[1]]+e[8];l=l+1;e=o[l];d=e[7];do return n[d](a(n,d+1,e[1]))end;l=l+1;e=o[l];d=e[7];do return a(n,d,c)end;l=l+1;e=o[l];do return end;end;elseif d<=12 then if d==11 then local o=e[7]local d={n[o](a(n,o+1,c))};local l=0;for e=o,e[8]do l=l+1;n[e]=d[l];end else n[e[7]]=n[e[1]][e[8]];end;elseif d>13 then do return end;else local e=e[7];do return n[e](a(n,e+1,c))end;end;elseif d<=22 then if d<=18 then if d<=16 then if d>15 then n[e[7]]=e[1]^n[e[8]];else local l=e[7];local o=n[e[1]];n[l+1]=o;n[l]=o[e[8]];end;elseif d==17 then local e=e[7]n[e](a(n,e+1,c))else n[e[7]]=n[e[1]]+n[e[8]];end;elseif d<=20 then if d==19 then local e=e[7]n[e]=n[e](n[e+1])else local d,d;local i;local N;local s;local t;local d;local E,I,K,L;for n,l in r(G)do for o,n in r(l[2])do E,I,K,L={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#E do I,K=I..J(h(E[e],K)),(K+L)%256 end l[n],l[2]=I,{};end end;l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];d=e[7]n[d]=n[d](n[d+1])l=l+1;e=o[l];d=e[7]s={n[d]()};N=e[8];i=0;for e=d,N do i=i+1;n[e]=s[i];end l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];d=e[7]s,N=M(n[d](n[d+1]))c=N+d-1 i=0;for e=d,c do i=i+1;n[e]=s[i];end;l=l+1;e=o[l];d=e[7]n[d](a(n,d+1,c))l=l+1;e=o[l];n[e[7]]={};l=l+1;e=o[l];n[e[7]]=e[1];end;elseif d==21 then local e=e[7];do return a(n,e,c)end;else n[e[7]][e[1]]=n[e[8]];end;elseif d<=26 then if d<=24 then if d==23 then local e=e[7]n[e]=n[e]()else local o=e[7];local a=n[o+2];local d=n[o]+a;n[o]=d;if(a>0)then if(d<=n[o+1])then l=e[1];n[o+i]=d;end elseif(d>=n[o+1])then l=e[1];n[o+i]=d;end end;elseif d==25 then local l=e[7];do return n[l](a(n,l+1,e[1]))end;else n[e[7]]=e[1]^n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]%n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]-e[8];l=l+1;e=o[l];n[e[7]]=e[1]^n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]%n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]-n[e[8]];l=l+1;e=o[l];if(e[7]<n[e[8]])then l=e[1];else l=l+1;end;end;elseif d<=28 then if d>27 then l=n[e[7]]and e[1]or l+1;else n[e[7]]=s[e[1]];end;elseif d==29 then local a=e[7];local d={};for e=1,#I do local e=I[e];for l=0,#e do local e=e[l];local o=e[1];local l=e[2];if o==n and l>=a then d[l]=o[l];e[1]=d;end;end;end;else local l=e[7];do return n[l](a(n,l+1,e[1]))end;end;elseif d<=45 then if d<=37 then if d<=33 then if d<=31 then l=e[1];elseif d==32 then local o=e[7];local d=n[o]local a=n[o+2];if(a>0)then if(d>n[o+1])then l=e[1];else n[o+i]=d;end elseif(d<n[o+1])then l=e[1];else n[o+i]=d;end else l=e[1];end;elseif d<=35 then if d==34 then local e=e[7];do return a(n,e,c)end;else local l=e[7];local o=n[l];local d=50*e[8];for e=l+1,e[1]do o[d+e-l]=n[e]end;end;elseif d>36 then n[e[7]]=n[e[1]]-n[e[8]];else do return n[e[7]]end end;elseif d<=41 then if d<=39 then if d>38 then local e=e[7]n[e](n[e+1])else n[e[7]]=#n[e[1]];end;elseif d==40 then n[e[7]]=n[e[1]]-e[8];else local o=e[7];local l=n[e[1]];n[o+1]=l;n[o]=l[e[8]];end;elseif d<=43 then if d>42 then n[e[7]]=E(L[e[1]],nil,f);else l=n[e[7]]and e[1]or l+1;end;elseif d>44 then n[e[7]][e[1]]=e[8];else l=n[e[7]]==e[8]and l+1 or e[1];end;elseif d<=53 then if d<=49 then if d<=47 then if d==46 then if(e[7]<n[e[8]])then l=e[1];else l=l+1;end;else n[e[7]]=(e[1]~=0);end;elseif d==48 then n[e[7]]=e[1]-n[e[8]];else l=n[e[7]]==e[8]and e[1]or l+1;end;elseif d<=51 then if d>50 then if(n[e[7]]<e[8])then l=l+1;else l=e[1];end;else n[e[7]]={};end;elseif d==52 then n[e[7]]();else l=n[e[7]]==e[8]and e[1]or l+1;end;elseif d<=57 then if d<=55 then if d==54 then for n,l in r(G)do for n,o in r(l[2])do local d,e,n,a={l[o]:byte(1,#l[o])},'',e[7],e[1]for o=1,#d do e,n=e..J(h(d[o],n)),(n+a)%256 end l[o],l[2]=e,{};end end;else local e=e[7]n[e]=n[e](n[e+1])end;elseif d==56 then local d=e[7];local a=e[8];local o=d+2 local d={n[d](n[d+1],n[o])};for e=1,a do n[o+e]=d[e];end;local d=d[1]if d then n[o]=d l=e[1];else l=l+1;end;else local c=L[e[1]];local a;local d={};a=D({},{__index=function(l,e)local e=d[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=d[e]e[1][e[2]]=l;end;});for a=1,e[8]do l=l+1;local e=o[l];if e[4]==94 then d[a-1]={n,e[1]};else d[a-1]={s,e[1]};end;I[#I+1]=d;end;n[e[7]]=E(c,a,f);end;elseif d<=59 then if d>58 then n[e[7]]=s[e[1]];else local l=e[7]local o,e=M(n[l](a(n,l+1,e[1])))c=e+l-1 local e=0;for l=l,c do e=e+1;n[l]=o[e];end;end;elseif d>60 then n[e[7]]=n[e[1]]%e[8];else n[e[7]]();end;elseif d<=92 then if d<=76 then if d<=68 then if d<=64 then if d<=62 then local t=L[e[1]];local c;local d={};c=D({},{__index=function(l,e)local e=d[e];return e[1][e[2]];end,__newindex=function(n,e,l)local e=d[e]e[1][e[2]]=l;end;});for a=1,e[8]do l=l+1;local e=o[l];if e[4]==94 then d[a-1]={n,e[1]};else d[a-1]={s,e[1]};end;I[#I+1]=d;end;n[e[7]]=E(t,c,f);elseif d==63 then l=n[e[7]]and l+1 or e[1];else local l=e[7]local d={n[l](n[l+1])};local o=0;for e=l,e[8]do o=o+1;n[e]=d[o];end end;elseif d<=66 then if d==65 then n[e[7]]=e[1]^n[e[8]];else n[e[7]]=n[e[1]][n[e[8]]];end;elseif d==67 then local e=e[7]local o,l=M(n[e](n[e+1]))c=l+e-1 local l=0;for e=e,c do l=l+1;n[e]=o[l];end;else local d;local a;n[e[7]]=n[e[1]]%e[8];l=l+1;e=o[l];n[e[7]]=n[e[1]]+e[8];l=l+1;e=o[l];n[e[7]]=n[e[1]][n[e[8]]];l=l+1;e=o[l];a=e[1];d=n[a]for e=a+1,e[8]do d=d..n[e];end;n[e[7]]=d;l=l+1;e=o[l];do return n[e[7]]end l=l+1;e=o[l];do return end;end;elseif d<=72 then if d<=70 then if d>69 then n[e[7]]=n[e[1]]%n[e[8]];else local t;local c;local d;d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]={};l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7];c=n[d];t=50*e[8];for e=d+1,e[1]do c[t+e-d]=n[e]end;end;elseif d>71 then n[e[7]]=#n[e[1]];else if(n[e[7]]<e[8])then l=l+1;else l=e[1];end;end;elseif d<=74 then if d==73 then do return end;else n[e[7]]=e[1];end;elseif d>75 then local o=e[1];local l=n[o]for e=o+1,e[8]do l=l..n[e];end;n[e[7]]=l;else n[e[7]]=n[e[1]];end;elseif d<=84 then if d<=80 then if d<=78 then if d==77 then local l=e[7];local d=n[l];local o=50*e[8];for e=l+1,e[1]do d[o+e-l]=n[e]end;else local i;local h,r;local t;local d;n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]h,r=M(n[d](a(n,d+1,e[1])))c=r+d-1 i=0;for e=d,c do i=i+1;n[e]=h[i];end;l=l+1;e=o[l];d=e[7];do return n[d](a(n,d+1,c))end;l=l+1;e=o[l];d=e[7];do return a(n,d,c)end;l=l+1;e=o[l];do return end;end;elseif d==79 then n[e[7]]=n[e[1]][e[8]];else n[e[7]]=n[e[1]]+e[8];end;elseif d<=82 then if d==81 then l=n[e[7]]and l+1 or e[1];else local a;local s;local d;local i,t,c,M;n[e[7]]={};l=l+1;e=o[l];for n,l in r(G)do for o,n in r(l[2])do i,t,c,M={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#i do t,c=t..J(h(i[e],c)),(c+M)%256 end l[n],l[2]=t,{};end end;l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]s={n[d](n[d+1])};a=0;for e=d,e[8]do a=a+1;n[e]=s[a];end l=l+1;e=o[l];l=e[1];end;elseif d==83 then n[e[7]]=n[e[1]]-n[e[8]];else n[e[7]]=f[e[1]];end;elseif d<=88 then if d<=86 then if d==85 then local r;local i;local h,J;local t;local d;n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]n[d]=n[d](n[d+1])l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]n[d]=n[d](n[d+1])l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7]h,J=M(n[d](n[d+1]))c=J+d-1 i=0;for e=d,c do i=i+1;n[e]=h[i];end;l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,c))l=l+1;e=o[l];t=e[1];r=n[t]for e=t+1,e[8]do r=r..n[e];end;n[e[7]]=r;l=l+1;e=o[l];n[e[7]][n[e[1]]]=n[e[8]];else n[e[7]][n[e[1]]]=n[e[8]];end;elseif d==87 then local o=e[1];local l=n[o]for e=o+1,e[8]do l=l..n[e];end;n[e[7]]=l;else local a=e[7];local d={};for e=1,#I do local e=I[e];for l=0,#e do local l=e[l];local o=l[1];local e=l[2];if o==n and e>=a then d[e]=o[e];l[1]=d;end;end;end;end;elseif d<=90 then if d>89 then n[e[7]]=n[e[1]][n[e[8]]];else local c;local d;n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];c=n[e[1]];n[d+1]=c;n[d]=c[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];d=e[7];c=n[e[1]];n[d+1]=c;n[d]=c[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))end;elseif d==91 then local e=e[7]n[e](a(n,e+1,c))else n[e[7]]=n[e[1]]%e[8];end;elseif d<=108 then if d<=100 then if d<=96 then if d<=94 then if d==93 then n[e[7]]=e[1];else n[e[7]]=n[e[1]];end;elseif d==95 then local M;local a;local f;local d;local s,c,t,I;for n,l in r(G)do for o,n in r(l[2])do s,c,t,I={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#s do c,t=c..J(h(s[e],t)),(t+I)%256 end l[n],l[2]=c,{};end end;l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7];f=n[e[1]];n[d+1]=f;n[d]=f[e[8]];l=l+1;e=o[l];d=e[7]n[d]=n[d](n[d+1])l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7];a=n[d]M=n[d+2];if(M>0)then if(a>n[d+1])then l=e[1];else n[d+i]=a;end elseif(a<n[d+1])then l=e[1];else n[d+i]=a;end else local e=e[7]n[e](n[e+1])end;elseif d<=98 then if d>97 then local o=e[7];local a=n[o+2];local d=n[o]+a;n[o]=d;if(a>0)then if(d<=n[o+1])then l=e[1];n[o+i]=d;end elseif(d>=n[o+1])then l=e[1];n[o+i]=d;end else do return n[e[7]]end end;elseif d==99 then for n,l in r(G)do for o,n in r(l[2])do local d,e,o,a={l[n]:byte(1,#l[n])},'',e[7],e[1]for n=1,#d do e,o=e..J(h(d[n],o)),(o+a)%256 end l[n],l[2]=e,{};end end;else local t;local c;local d;d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];c=e[1];t=n[c]for e=c+1,e[8]do t=t..n[e];end;n[e[7]]=t;l=l+1;e=o[l];d=e[7];c=n[e[1]];n[d+1]=c;n[d]=c[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];end;elseif d<=104 then if d<=102 then if d==101 then local d;local t;local I,E;local K;local d;local N,i,s,L;for n,l in r(G)do for o,n in r(l[2])do N,i,s,L={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#N do i,s=i..J(h(N[e],s)),(s+L)%256 end l[n],l[2]=i,{};end end;l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];K=n[e[1]];n[d+1]=K;n[d]=K[e[8]];l=l+1;e=o[l];d=e[7]I,E=M(n[d](n[d+1]))c=E+d-1 t=0;for e=d,c do t=t+1;n[e]=I[t];end;l=l+1;e=o[l];d=e[7]I={n[d](a(n,d+1,c))};t=0;for e=d,e[8]do t=t+1;n[e]=I[t];end l=l+1;e=o[l];l=e[1];else local e=e[7]n[e]=n[e](a(n,e+1,c))end;elseif d>103 then local i;local N,K;local d;local I,t,f,E;n[e[7]]=s[e[1]];l=l+1;e=o[l];for n,l in r(G)do for o,n in r(l[2])do I,t,f,E={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#I do t,f=t..J(h(I[e],f)),(f+E)%256 end l[n],l[2]=t,{};end end;l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];n[e[7]]={};l=l+1;e=o[l];n[e[7]][e[1]]=e[8];l=l+1;e=o[l];n[e[7]][e[1]]=e[8];l=l+1;e=o[l];d=e[7]N,K=M(n[d](a(n,d+1,e[1])))c=K+d-1 i=0;for e=d,c do i=i+1;n[e]=N[i];end;l=l+1;e=o[l];d=e[7];do return n[d](a(n,d+1,c))end;l=l+1;e=o[l];d=e[7];do return a(n,d,c)end;l=l+1;e=o[l];do return end;else local e=e[7]n[e]=n[e]()end;elseif d<=106 then if d>105 then local o=e[7]local d={n[o](n[o+1])};local l=0;for e=o,e[8]do l=l+1;n[e]=d[l];end else if(e[7]<n[e[8]])then l=e[1];else l=l+1;end;end;elseif d>107 then n[e[7]]=n[e[1]]%n[e[8]];else local l=e[7]local o={n[l]()};local d=e[8];local e=0;for l=l,d do e=e+1;n[l]=o[e];end end;elseif d<=116 then if d<=112 then if d<=110 then if d==109 then n[e[7]][n[e[1]]]=n[e[8]];else local t,c,a,f;local d;n[e[7]]=s[e[1]];l=l+1;e=o[l];d=e[7]n[d]=n[d]()l=l+1;e=o[l];for n,l in r(G)do for o,n in r(l[2])do t,c,a,f={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#t do c,a=c..J(h(t[e],a)),(a+f)%256 end l[n],l[2]=c,{};end end;l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d](n[d+1])l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]();l=l+1;e=o[l];do return end;end;elseif d>111 then local a;local t,d,c,i;for n,l in r(G)do for o,n in r(l[2])do t,d,c,i={l[n]:byte(1,#l[n])},'',e[7],e[1]for e=1,#t do d,c=d..J(h(t[e],c)),(c+i)%256 end l[n],l[2]=d,{};end end;l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];a=e[7]n[a]=n[a](n[a+1])l=l+1;e=o[l];n[e[7]]();l=l+1;e=o[l];do return end;else local o=e[7];local d=n[o]local a=n[o+2];if(a>0)then if(d>n[o+1])then l=e[1];else n[o+i]=d;end elseif(d<n[o+1])then l=e[1];else n[o+i]=d;end end;elseif d<=114 then if d>113 then n[e[7]]=e[1]^n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]%n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]-e[8];l=l+1;e=o[l];n[e[7]]=e[1]^n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]%n[e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]]-n[e[8]];l=l+1;e=o[l];if(e[7]<n[e[8]])then l=e[1];else l=l+1;end;else n[e[7]]=n[e[1]]-e[8];end;elseif d==115 then local d;n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7];do return n[d](a(n,d+1,e[1]))end;l=l+1;e=o[l];d=e[7];do return a(n,d,c)end;l=l+1;e=o[l];do return end;else n[e[7]]=f[e[1]];end;elseif d<=120 then if d<=118 then if d>117 then local i;local r,h;local t;local d;d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]={};l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,e[1]))l=l+1;e=o[l];d=e[7];t=n[e[1]];n[d+1]=t;n[d]=t[e[8]];l=l+1;e=o[l];n[e[7]]=e[1];l=l+1;e=o[l];d=e[7]r,h=M(n[d](a(n,d+1,e[1])))c=h+d-1 i=0;for e=d,c do i=i+1;n[e]=r[i];end;l=l+1;e=o[l];d=e[7]n[d]=n[d](a(n,d+1,c))l=l+1;e=o[l];n[e[7]][e[1]]=n[e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]][e[1]]=n[e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]][e[1]]=n[e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];n[e[7]][e[1]]=n[e[8]];l=l+1;e=o[l];n[e[7]]=s[e[1]];l=l+1;e=o[l];n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]][e[8]];l=l+1;e=o[l];d=e[7]n[d]=n[d](n[d+1])l=l+1;e=o[l];n[e[7]][e[1]]=n[e[8]];l=l+1;e=o[l];d=e[7]r,h=M(n[d](n[d+1]))c=h+d-1 i=0;for e=d,c do i=i+1;n[e]=r[i];end;l=l+1;e=o[l];d=e[7]n[d](a(n,d+1,c))l=l+1;e=o[l];l=e[1];else local e=e[7];do return n[e](a(n,e+1,c))end;end;elseif d>119 then local l=e[7]n[l]=n[l](a(n,l+1,e[1]))else local l=e[7]local o,e=M(n[l](a(n,l+1,e[1])))c=e+l-1 local e=0;for l=l,c do e=e+1;n[l]=o[e];end;end;elseif d<=122 then if d>121 then n[e[7]]=(e[1]~=0);else local o=e[7];local a=e[8];local d=o+2 local o={n[o](n[o+1],n[d])};for e=1,a do n[d+e]=o[e];end;local o=o[1]if o then n[d]=o l=e[1];else l=l+1;end;end;elseif d==123 then local l=e[7]local d={n[l]()};local o=e[8];local e=0;for l=l,o do e=e+1;n[l]=d[e];end else local a;local c;local d;n[e[7]]=f[e[1]];l=l+1;e=o[l];n[e[7]]={};l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];n[e[7]]=n[e[1]];l=l+1;e=o[l];d=e[7];c=n[d];a=50*e[8];for e=d+1,e[1]do c[a+e-d]=n[e]end;end;l=l+1;end;end;end;return a({E(Q(),{},B())()})or nil;end)(3,table.concat,({1})[1],{})
end)();

local Figure = script.Parent
local Torso = Figure:WaitForChild("Torso")
local RightShoulder = Torso:WaitForChild("Right Shoulder")
local LeftShoulder = Torso:WaitForChild("Left Shoulder")
local RightHip = Torso:WaitForChild("Right Hip")
local LeftHip = Torso:WaitForChild("Left Hip")
local Neck = Torso:WaitForChild("Neck")
local Humanoid = Figure:WaitForChild("Humanoid")
local pose = "Standing"

local currentAnim = ""
local currentAnimInstance = nil
local currentAnimTrack = nil
local currentAnimKeyframeHandler = nil
local currentAnimSpeed = 1.0
local animTable = {}
local animNames = { 
	idle = 	{	
				{ id = "http://www.roblox.com/asset/?id=180435571", weight = 9 },
				{ id = "http://www.roblox.com/asset/?id=180435792", weight = 1 }
			},
	walk = 	{ 	
				{ id = "http://www.roblox.com/asset/?id=180426354", weight = 10 } 
			}, 
	run = 	{
				{ id = "run.xml", weight = 10 } 
			}, 
	jump = 	{
				{ id = "http://www.roblox.com/asset/?id=125750702", weight = 10 } 
			}, 
	fall = 	{
				{ id = "http://www.roblox.com/asset/?id=180436148", weight = 10 } 
			}, 
	climb = {
				{ id = "http://www.roblox.com/asset/?id=180436334", weight = 10 } 
			}, 
	sit = 	{
				{ id = "http://www.roblox.com/asset/?id=178130996", weight = 10 } 
			},	
	toolnone = {
				{ id = "http://www.roblox.com/asset/?id=182393478", weight = 10 } 
			},
	toolslash = {
				{ id = "http://www.roblox.com/asset/?id=129967390", weight = 10 } 
--				{ id = "slash.xml", weight = 10 } 
			},
	toollunge = {
				{ id = "http://www.roblox.com/asset/?id=129967478", weight = 10 } 
			},
	wave = {
				{ id = "http://www.roblox.com/asset/?id=128777973", weight = 10 } 
			},
	point = {
				{ id = "http://www.roblox.com/asset/?id=128853357", weight = 10 } 
			},
	dance1 = {
				{ id = "http://www.roblox.com/asset/?id=182435998", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491037", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491065", weight = 10 } 
			},
	dance2 = {
				{ id = "http://www.roblox.com/asset/?id=182436842", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491248", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491277", weight = 10 } 
			},
	dance3 = {
				{ id = "http://www.roblox.com/asset/?id=182436935", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491368", weight = 10 }, 
				{ id = "http://www.roblox.com/asset/?id=182491423", weight = 10 } 
			},
	laugh = {
				{ id = "http://www.roblox.com/asset/?id=129423131", weight = 10 } 
			},
	cheer = {
				{ id = "http://www.roblox.com/asset/?id=129423030", weight = 10 } 
			},
}
local dances = {"dance1", "dance2", "dance3"}

-- Existance in this list signifies that it is an emote, the value indicates if it is a looping emote
local emoteNames = { wave = false, point = false, dance1 = true, dance2 = true, dance3 = true, laugh = false, cheer = false}

function configureAnimationSet(name, fileList)
	if (animTable[name] ~= nil) then
		for _, connection in pairs(animTable[name].connections) do
			connection:disconnect()
		end
	end
	animTable[name] = {}
	animTable[name].count = 0
	animTable[name].totalWeight = 0	
	animTable[name].connections = {}

	-- check for config values
	local config = script:FindFirstChild(name)
	if (config ~= nil) then
--		print("Loading anims " .. name)
		table.insert(animTable[name].connections, config.ChildAdded:connect(function(child) configureAnimationSet(name, fileList) end))
		table.insert(animTable[name].connections, config.ChildRemoved:connect(function(child) configureAnimationSet(name, fileList) end))
		local idx = 1
		for _, childPart in pairs(config:GetChildren()) do
			if (childPart:IsA("Animation")) then
				table.insert(animTable[name].connections, childPart.Changed:connect(function(property) configureAnimationSet(name, fileList) end))
				animTable[name][idx] = {}
				animTable[name][idx].anim = childPart
				local weightObject = childPart:FindFirstChild("Weight")
				if (weightObject == nil) then
					animTable[name][idx].weight = 1
				else
					animTable[name][idx].weight = weightObject.Value
				end
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
	--			print(name .. " [" .. idx .. "] " .. animTable[name][idx].anim.AnimationId .. " (" .. animTable[name][idx].weight .. ")")
				idx = idx + 1
			end
		end
	end

	-- fallback to defaults
	if (animTable[name].count <= 0) then
		for idx, anim in pairs(fileList) do
			animTable[name][idx] = {}
			animTable[name][idx].anim = Instance.new("Animation")
			animTable[name][idx].anim.Name = name
			animTable[name][idx].anim.AnimationId = anim.id
			animTable[name][idx].weight = anim.weight
			animTable[name].count = animTable[name].count + 1
			animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
--			print(name .. " [" .. idx .. "] " .. anim.id .. " (" .. anim.weight .. ")")
		end
	end
end

-- Setup animation objects
function scriptChildModified(child)
	local fileList = animNames[child.Name]
	if (fileList ~= nil) then
		configureAnimationSet(child.Name, fileList)
	end	
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)


for name, fileList in pairs(animNames) do 
	configureAnimationSet(name, fileList)
end	

-- ANIMATION

-- declarations
local toolAnim = "None"
local toolAnimTime = 0

local jumpAnimTime = 0
local jumpAnimDuration = 0.3

local toolTransitionTime = 0.1
local fallTransitionTime = 0.3
local jumpMaxLimbVelocity = 0.75

-- functions

function stopAllAnimations()
	local oldAnim = currentAnim

	-- return to idle if finishing an emote
	if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
		oldAnim = "idle"
	end

	currentAnim = ""
	currentAnimInstance = nil
	if (currentAnimKeyframeHandler ~= nil) then
		currentAnimKeyframeHandler:disconnect()
	end

	if (currentAnimTrack ~= nil) then
		currentAnimTrack:Stop()
		currentAnimTrack:Destroy()
		currentAnimTrack = nil
	end
	return oldAnim
end

function setAnimationSpeed(speed)
	if speed ~= currentAnimSpeed then
		currentAnimSpeed = speed
		currentAnimTrack:AdjustSpeed(currentAnimSpeed)
	end
end

function keyFrameReachedFunc(frameName)
	if (frameName == "End") then

		local repeatAnim = currentAnim
		-- return to idle if finishing an emote
		if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
			repeatAnim = "idle"
		end
		
		local animSpeed = currentAnimSpeed
		playAnimation(repeatAnim, 0.0, Humanoid)
		setAnimationSpeed(animSpeed)
	end
end

-- Preload animations
function playAnimation(animName, transitionTime, humanoid) 
		
	local roll = math.random(1, animTable[animName].totalWeight) 
	local origRoll = roll
	local idx = 1
	while (roll > animTable[animName][idx].weight) do
		roll = roll - animTable[animName][idx].weight
		idx = idx + 1
	end
--		print(animName .. " " .. idx .. " [" .. origRoll .. "]")
	local anim = animTable[animName][idx].anim

	-- switch animation		
	if (anim ~= currentAnimInstance) then
		
		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop(transitionTime)
			currentAnimTrack:Destroy()
		end

		currentAnimSpeed = 1.0
	
		-- load it to the humanoid; get AnimationTrack
		currentAnimTrack = humanoid:LoadAnimation(anim)
		currentAnimTrack.Priority = Enum.AnimationPriority.Core
		 
		-- play the animation
		currentAnimTrack:Play(transitionTime)
		currentAnim = animName
		currentAnimInstance = anim

		-- set up keyframe name triggers
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end
		currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
		
	end

end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

local toolAnimName = ""
local toolAnimTrack = nil
local toolAnimInstance = nil
local currentToolAnimKeyframeHandler = nil

function toolKeyFrameReachedFunc(frameName)
	if (frameName == "End") then
--		print("Keyframe : ".. frameName)	
		playToolAnimation(toolAnimName, 0.0, Humanoid)
	end
end


function playToolAnimation(animName, transitionTime, humanoid, priority)	 
		
		local roll = math.random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
--		print(animName .. " * " .. idx .. " [" .. origRoll .. "]")
		local anim = animTable[animName][idx].anim

		if (toolAnimInstance ~= anim) then
			
			if (toolAnimTrack ~= nil) then
				toolAnimTrack:Stop()
				toolAnimTrack:Destroy()
				transitionTime = 0
			end
					
			-- load it to the humanoid; get AnimationTrack
			toolAnimTrack = humanoid:LoadAnimation(anim)
			if priority then
				toolAnimTrack.Priority = priority
			end
			 
			-- play the animation
			toolAnimTrack:Play(transitionTime)
			toolAnimName = animName
			toolAnimInstance = anim

			currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
end

function stopToolAnimations()
	local oldAnim = toolAnimName

	if (currentToolAnimKeyframeHandler ~= nil) then
		currentToolAnimKeyframeHandler:disconnect()
	end

	toolAnimName = ""
	toolAnimInstance = nil
	if (toolAnimTrack ~= nil) then
		toolAnimTrack:Stop()
		toolAnimTrack:Destroy()
		toolAnimTrack = nil
	end


	return oldAnim
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


function onRunning(speed)
	if speed > 0.01 then
		playAnimation("walk", 0.1, Humanoid)
		if currentAnimInstance and currentAnimInstance.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
			setAnimationSpeed(speed / 14.5)
		end
		pose = "Running"
	else
		if emoteNames[currentAnim] == nil then
			playAnimation("idle", 0.1, Humanoid)
			pose = "Standing"
		end
	end
end

function onDied()
	pose = "Dead"
end

function onJumping()
	playAnimation("jump", 0.1, Humanoid)
	jumpAnimTime = jumpAnimDuration
	pose = "Jumping"
end

function onClimbing(speed)
	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(speed / 12.0)
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	if (jumpAnimTime <= 0) then
		playAnimation("fall", fallTransitionTime, Humanoid)
	end
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	pose = "Seated"
end

function onPlatformStanding()
	pose = "PlatformStanding"
end

function onSwimming(speed)
	if speed > 0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function getTool()	
	for _, kid in ipairs(Figure:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end

function getToolAnim(tool)
	for _, c in ipairs(tool:GetChildren()) do
		if c.Name == "toolanim" and c.className == "StringValue" then
			return c
		end
	end
	return nil
end

function animateTool()
	
	if (toolAnim == "None") then
		playToolAnimation("toolnone", toolTransitionTime, Humanoid, Enum.AnimationPriority.Idle)
		return
	end

	if (toolAnim == "Slash") then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
		return
	end

	if (toolAnim == "Lunge") then
		playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
		return
	end
end

function moveSit()
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder:SetDesiredAngle(3.14 /2)
	LeftShoulder:SetDesiredAngle(-3.14 /2)
	RightHip:SetDesiredAngle(3.14 /2)
	LeftHip:SetDesiredAngle(-3.14 /2)
end

local lastTick = 0

function move(time)
	local amplitude = 1
	local frequency = 1
  	local deltaTime = time - lastTick
  	lastTick = time

	local climbFudge = 0
	local setAngles = false

  	if (jumpAnimTime > 0) then
  		jumpAnimTime = jumpAnimTime - deltaTime
  	end

	if (pose == "FreeFall" and jumpAnimTime <= 0) then
		playAnimation("fall", fallTransitionTime, Humanoid)
	elseif (pose == "Seated") then
		playAnimation("sit", 0.5, Humanoid)
		return
	elseif (pose == "Running") then
		playAnimation("walk", 0.1, Humanoid)
	elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
--		print("Wha " .. pose)
		stopAllAnimations()
		amplitude = 0.1
		frequency = 1
		setAngles = true
	end

	if (setAngles) then
		local desiredAngle = amplitude * math.sin(time * frequency)

		RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
		LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
		RightHip:SetDesiredAngle(-desiredAngle)
		LeftHip:SetDesiredAngle(-desiredAngle)
	end

	-- Tool Animation handling
	local tool = getTool()
	if tool and tool:FindFirstChild("Handle") then
	
		local animStringValueObject = getToolAnim(tool)

		if animStringValueObject then
			toolAnim = animStringValueObject.Value
			-- message recieved, delete StringValue
			animStringValueObject.Parent = nil
			toolAnimTime = time + .3
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()		
	else
		stopToolAnimations()
		toolAnim = "None"
		toolAnimInstance = nil
		toolAnimTime = 0
	end
end

-- connect events
Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)

-- setup emote chat hook
game:GetService("Players").LocalPlayer.Chatted:connect(function(msg)
	local emote = ""
	if msg == "/e dance" then
		emote = dances[math.random(1, #dances)]
	elseif (string.sub(msg, 1, 3) == "/e ") then
		emote = string.sub(msg, 4)
	elseif (string.sub(msg, 1, 7) == "/emote ") then
		emote = string.sub(msg, 8)
	end
	
	if (pose == "Standing" and emoteNames[emote] ~= nil) then
		playAnimation(emote, 0.1, Humanoid)
	end

end)


-- main program

-- initialize to idle
playAnimation("idle", 0.1, Humanoid)
pose = "Standing"

while Figure.Parent ~= nil do
	local _, time = wait(0.1)
	move(time)
end


