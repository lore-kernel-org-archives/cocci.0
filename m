From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon,  2 Dec 2013 16:46:09 +0100
Subject: [Cocci] [PATCH 2/2] coccinelle: add .gitignore file
In-Reply-To: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
References: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1385999169-19497-2-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Stash into it a series of files which we do not need
to keep track via git as they are generated upon build
time and can be system specific.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .gitignore              |   4 +
 myocamlbuild.ml         | 297 ------------------------------------------------
 python/coccipython.a    | Bin 25580 -> 0 bytes
 python/coccipython.cmxa | Bin 2575 -> 0 bytes
 version.ml              |   2 -
 5 files changed, 4 insertions(+), 299 deletions(-)
 create mode 100644 .gitignore
 delete mode 100644 myocamlbuild.ml
 delete mode 100644 python/coccipython.a
 delete mode 100644 python/coccipython.cmxa
 delete mode 100644 version.ml

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..6562e2f
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,4 @@
+myocamlbuild.ml
+python/coccipython.a
+python/coccipython.cmxa
+version.ml
diff --git a/myocamlbuild.ml b/myocamlbuild.ml
deleted file mode 100644
index 39f69af..0000000
--- a/myocamlbuild.ml
+++ /dev/null
@@ -1,297 +0,0 @@
-# 2 "myocamlbuild.ml.in"
-
-(*
- * This file is a plugin that provides the needed customization of
- * calls to the ocaml compiler needed for components of coccinelle.
- * The classification of particular components is done by tags, which
- * are specified in the _tags file.
- *
- * This file is also a compromise: some aspects of coccocinelle's
- * build process are somehwat complicated due to packaging some
- * bundled software, having no requirement on ocamlfind, etc.
- * We therefore let 'configure' find out the configuration and
- * paths to tools and libraries, and this plugin is transformed
- * by that configuration to customize ocamlbuild accordingly.
- *)
-
-(* Some useful commandline arguments to ocamlbuild are:
- *   -yaccflag -v      verbose ocamlyacc and menhir output
- *   -classic-display  see the individual build steps
- *   -j 0              parallel building
- *   -tag "-custom"    pure bytecode building
- *   -tag "-dtypes"    no type annotation generation
- *)
-
-
-(* Configuration of this build plugin
- *)
-
-let ocamlc_path     = "/usr/bin/ocamlc.opt"
-let ocamlopt_path   = "/usr/bin/ocamlopt.opt"
-let ocamldep_path   = "/usr/bin/ocamldep"
-let ocamldoc_path   = "/usr/bin/ocamldoc"
-let ocamlyacc_path  = "/usr/bin/ocamlyacc"
-let ocamllex_path   = "/usr/bin/ocamllex.opt"
-let ocamlmklib_path = "/usr/bin/ocamlmklib"
-let ocamlmktop_path = "/usr/bin/ocamlmktop"
-let camlp4o_path    = "/usr/bin/camlp4o"
-let menhir_path     = "/usr/bin/menhir"
-
-let pycaml_path     = ""
-let pcre_path       = ""
-let menhirLib_path  = "/usr/lib/ocaml/menhirLib"
-let dynlink_path    = "/usr/lib/ocaml"
-
-let pcre_cflags     = ""
-let pcre_ldflags    = ""
-let python_cflags   = ""
-let python_ldflags  = ""
-let python_major_version = ""
-
-let profiling_modules = ""
-
-
-(* The plugin code starts here. *)
-open Ocamlbuild_plugin
-open Command
-
-(* Removes double separators and single dots from
- * a path. It does not resolve symlinks or turn
- * relative paths in absolute paths.
- *)
-let rec normalize_path path =
-  let parent = Pathname.dirname path in
-  if Pathname.equal path "/" || Pathname.equal parent "/" || Pathname.equal parent path
-  then path
-  else let name = Pathname.basename path in
-       if Pathname.equal name "."
-       then normalize_path parent
-       else normalize_path parent / name
-
-(* Makes path relative and implicit, if it is a child of the
- * current directory. Relative paths are a must when dealing
- * with the build directory.
- * Todo: find out if there is a library function for
- * exactly this purpose.
- *)
-let relative_path path =
-  let current = normalize_path Pathname.pwd in
-  let target = normalize_path path in
-  if Pathname.is_prefix current target
-  then let len_current = String.length current in
-       let len_target = String.length target in
-       if len_current == len_target
-       then "."
-       else let len_tail = len_target - len_current - 1 in
-            let ind_tail = len_current + 1 in
-	    String.sub target ind_tail len_tail
-  else target
-
-let add_flags flag_ref flags =
-  flag_ref := List.append flags !flag_ref
-
-
-let mk_use_tag name = "use_" ^ name
-
-
-(* Sets up a tag for compiling c and library files against
- * an external c library.
- *)
-let setup_clib name compile_flags link_flags =
-  let tag = mk_use_tag name in
-  flag [tag; "c"; "compile"] (S[A "-ccopt"; A compile_flags]);
-  flag [tag; "c"; "ocamlmklib"] (S[A "-ldopt"; A link_flags]);
-  flag [tag; "ocaml"; "link"] (S[A "-ccopt"; A compile_flags]);
-  flag [tag; "ocaml"; "link"] (S[A "-ccopt"; A link_flags])
-
-(* Sets up a tag for declaring a dependency on a stubs library,
- * and linking it in. The dependency includes both a .a archive
- * and a .so dll.
- *)
-let setup_stubs name stubs_dir =
-  let tag     = mk_use_tag name in
-  let path_a  = Printf.sprintf "%s/lib%s_stubs.a" stubs_dir name in
-  if not (Pathname.exists path_a) then
-    dep [tag; "link"; "ocaml"] [path_a];
-  let stubs_arg = Printf.sprintf "-l%s_stubs" name in
-  flag [tag; "ocaml"; "link"; "byte"]
-    (S[A "-I"; P stubs_dir; A "-dllib"; A stubs_arg; A "-cclib"; A stubs_arg]);
-  flag [tag; "ocaml"; "link"; "native"]
-    (S[A "-I"; P stubs_dir; A "-cclib"; A stubs_arg]);
-  flag [tag; "ocaml"; "doc"]
-    (S[A "-I"; P stubs_dir])
-
-(* The use of bundled software is simply the
- * inclusion of the appropriate source directory.
- * The build system can find automatically how to
- * deal with the bundled sources.
- *)
-let setup_bundle rootdir =
-  tag_file rootdir ["include"; "traverse"]
-
-(* Sets up a tag that adds the given module directory and module
- * as additional argument to ocaml when it processes a
- * file with that tag.
- * Todo: it may be beneficial to add a dependency on the target
- * module.
- *)
-let setup_module name modname rootdir =
-  let tag = mk_use_tag name in
-  let link_args isNative = S [A "-I"; P rootdir; A (modname isNative) ] in
-  let compile_args = S [A "-I"; P rootdir] in
-  flag [tag; "ocaml"; "compile"] compile_args;
-  flag [tag; "ocaml"; "byte"; "link"; "program"]   (link_args false);
-  flag [tag; "ocaml"; "native"; "link"; "program"] (link_args true);
-  flag [tag; "ocaml"; "doc"] (S[A "-I"; P rootdir])
-
-(* Sets up the use of either a bundled source package or precompiled module. *)
-let setup_package name modname rootdir =
-  let exists_path isNative = Pathname.exists (rootdir / modname isNative) in
-  let is_binary = exists_path false || exists_path true in
-  if is_binary
-  then setup_module name modname rootdir
-  else setup_bundle rootdir
-
-
-(* Most files depend on these standard modules, hence we setup a
- * single tag for them.
- * This setup routine should be called before the others to ensure
- * that these modules appear first on the ocaml commandlines.
- *)
-let setup_basic_libs use_dynlink =
-  ocaml_lib ~extern:true ~tag_name:"use_base" "unix";
-  ocaml_lib ~extern:true ~tag_name:"use_base" "str";
-  ocaml_lib ~extern:true ~tag_name:"use_base" "nums";
-  ocaml_lib ~extern:true ~tag_name:"use_base" "bigarray";
-  if use_dynlink then
-    ocaml_lib ~extern:true ~tag_name:"use_base" "dynlink";
-  ()
-
-(* The menhir package provides individual object files
- * instead of an archive.
- *)
-let setup_menhirLib () =
-  let menhirLib_dir = relative_path menhirLib_path in
-  let modname isNative = match isNative with
-        true  -> "menhirLib.cmx"
-      | false -> "menhirLib.cmo" in
-
-  setup_package "menhirLib" modname menhirLib_dir
-
-(* Pycaml is a stubs library with some conditional
- * code that depends on the python version. We
- * additionally introduce a tag pp_pycaml which
- * runs the appropriate preprocessors.
- *)
-let setup_pycaml () =
-  let pycaml_dir = relative_path pycaml_path in
-  let modname isNative = match isNative with
-        true  -> "pycaml.cmxa"
-      | false -> "pycaml.cma" in
-
-  setup_package "pycaml" modname pycaml_dir;
-  setup_stubs "pycaml" pycaml_dir;
-  setup_clib "pycaml" python_cflags python_ldflags;
-
-  let macrodef = Printf.sprintf "-D PYMAJOR%s" python_major_version in
-  flag ["pp_pycaml"; "c"; "compile"] (S[A "-ccopt"; A macrodef]);
-  let camlp4cmd = Printf.sprintf "%s -parser Camlp4MacroParser -D PYMAJOR%s"
-    camlp4o_path python_major_version in
-  flag ["pp_pycaml"; "ocaml"; "pp"] (Sh camlp4cmd)
-
-(* Pcre is a standard stub library. *)
-let setup_pcre () =
-  let pcre_dir = relative_path pcre_path in
-  let modname isNative = match isNative with
-        true  -> "pcre.cmxa"
-      | false -> "pcre.cma" in
-
-  setup_package "pcre" modname pcre_dir;
-  setup_stubs "pcre" pcre_dir;
-  setup_clib "pcre" pcre_cflags pcre_ldflags
-
-(* Some utility code on strings and paths. *)
-let any_non_space str =
-  let have_non_space = ref false in
-  String.iter begin
-    fun c -> match c with
-        ' '  -> ()
-      | '\t' -> ()
-      | _    -> have_non_space := true
-    end str;
-  !have_non_space
-
-let not_empty str =
-  String.length str > 0 && any_non_space str
-
-let is_path_configured path =
-  not_empty path && Pathname.exists path
-
-(* Note: the setup of the modules is done before the hygiene phase
- * in order to benefit from additional "include" tags that may be
- * given to directories.
- *)
-let _ = dispatch begin
-  function
-    | Before_options ->
-        Options.hygiene      := true;
-        Options.sanitize     := true;
-        Options.make_links   := false;
-        Options.catch_errors := true;
-	Options.use_menhir   := true;
-
-	let menhir_wrapper = Printf.sprintf
-          "%s/setup/wrapper-menhir.sh" Pathname.pwd in
-        Options.ocamlc       := Sh ocamlc_path;
-	Options.ocamlopt     := Sh ocamlopt_path;
-	Options.ocamldep     := Sh ocamldep_path;
-	Options.ocamldoc     := Sh ocamldoc_path;
-	Options.ocamlyacc    := S[P menhir_wrapper; P ocamlyacc_path; P menhir_path];
-	Options.ocamllex     := Sh ocamllex_path;
-	Options.ocamlmklib   := Sh ocamlmklib_path;
-	Options.ocamlmktop   := Sh ocamlmktop_path;
-        ()
-
-    | Before_hygiene ->
-	let use_dynlink = is_path_configured dynlink_path in
-	setup_basic_libs use_dynlink;
-
-	if is_path_configured menhirLib_path then
-          setup_menhirLib ();
-
-	if is_path_configured pcre_path then
-          setup_pcre ();
-
-        if is_path_configured pycaml_path then
-          setup_pycaml ();
-        ()
-
-    | After_rules ->
-	(* produces a slightly faster native version *)
-	(* flag ["ocaml"; "compile"; "native"] (A "-unsafe"); *)
-
-	(* adds debugging info (including exception backtraces) *)
-	flag ["ocaml"; "compile"] (A "-g");
-
-	(* flags to parameterize ocamldoc to produce web pages *)
-	flag ["gen_html"; "ocaml"; "doc"]
-	  (S [A "-colorize-code"; A "-short-functors"; A "-all-params"]);
-        flag ["gen_man"; "ocaml"; "doc"]
-	  (S [A "-man"; A "-man-mini"]);
-
-	(* when profiling, link with profiling.cmo *)
-	if not_empty profiling_modules then
-          flag ["ocaml"; "link"; "byte"]
-	    (S [A profiling_modules]);
-
-	(* the warning about unused function arguments are disabled
-         * for files with this tag. *)
-	flag ["nowarn20"; "ocaml"; "compile"] (S [A "-w"; A "-20"]);
-
-	(* adds the custom option, unless 'nocustom' is given as a tag *)
-	if not (Tags.mem "nocustom" (tags_of_pathname "myocamlbuild.ml"))
-	then flag ["ocaml"; "link"; "byte"] (A "-custom");
-	()
-
-    | _ -> ()
-end
diff --git a/python/coccipython.a b/python/coccipython.a
deleted file mode 100644
index 928b52dc21ed74e60316c808e5c3c0cfa8ac65f8..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 25580
zcmeI44RBo5b%3u}gB91{1rtz!#4E6g_)~Tz*_MKVwPoyeVz5$7QGl>ouUFRA(rTk!
z8wq!U`03Od#YGLB#?z2iGmyl|FhNshs8iC3h#BNb=~QiK at sw#$Nn1>56H$^uN!_~V
z+<VUM+4J75LojKZa!1<t-gnPE_uQX%-+T9-_Zrt_hO&LvFZoEUHY8ftuIY#;+SbNn
zG5CWZe`B#kN8Eu}&k|$I8e<ku{rvw|Ty4z%<o|8^jS2tHW(NAZMzVw1Y(AaYGn`KE
z%#<_f9l2fkf(gWB2Y2Se<ASoK@=(68YbaMtC)yHggYmt43J|k;bucD7I53du&w~P+
zIKC!CB-7uYE)M0&<&kuvwWB>KQH0#f>Ed7sGHDIbP#j8^(6o44SlV>1KR1A}Ex}ka
zJR~MpC=ZPU6WChI6?O(=Y+Z-O^bTbPa^=j9{+vy9^I*D2jieh$Myd9xMg^1<N7B9d
z0@U(7xpZQ6n`?!td>XP#=S%rQzMQv0J5kD2Rjt$zG-D}0Q0&jS21hwpHBzpWE2nKA
z>&^Gu4C4WdpfQK?xxKk`DLa%emeYGPLwPJeG~nu1*T7O^cCY{$?#Y%z<z0h^%hxDw
z4cGyS%b9$kl-`jq?1UZ+*|&5Aq;~Ad_wTIOh%&(}olLerQ!3d~v;^yK7uO54hOL;E
zVBPg)O6go-Z+>X7FaSMF*p=|vW%C5162TmuQP8*g2C+@!?#z at m1*b)BIA6xdV43oT
zZ2uk at 1O_tYY#)jQbKs5&by&_6p#PL}X)>s-BWN*;+p562N|#59&_~)j!c6N2!+JlB
zBS%MApLOFHc3YGP+SWgq*_j>~+_?uUyR9Qw+4&Mjqi7DQsI4Q|SJBprmiCa&*_X at i
zPU8Rsy?W130Xj<m9?Y>lXj0b7YPq0g)xkwJR?XNVBWi{g8KFiN9{csMQsHV$A#P8I
zicHnE3aT-zLTjw5P+^iOR<A|PgK*K7*XcwYugR6)HEY^pvG&!87I$UuS#s}<TQ{9i
zR|l7C7wXLQrh3HGnC|yg_mg%vY0frFOzMGusZWhvvhp~x)Yy?N5B#tpHGU=@ZN0XA
zsCCPMyX#Xkn-)wxMt>+ZzG!7?ygQm2zc at 8^SAA-HIO<Z)Ok=L82cE4zV!`WA^)6en
z5r~U8vTVhJsI!t^YWxn!=h~AmLY_`(GK#5RL!sW at W+C5@TJ}`;Lh3hPDz`w^VC|hN
zA!D!xO|h1e at iR^lMnCXugVi*Ff_$)SMUwJ=E;aTtlr%0%x_irk+d%jED^oKY7R(~F
z{0v*90~?~LndHJ-O9734(3WAW0Z4rWi!;^*bz!M9!qyL@J%VY;E-0Wivr<0GU)y)`
z<jD!B{{~x<vGU4#FsVtHG`!`&W~h9~JBoR~-{p<gP~OlEW5baAP0DEFN-zd%1*(Aa
zRt@?=*6A7)+Tcz|GzQfQwM0$#ytA)>_8sZ9p|(As$(B9UxsW>GOv*00KUMebldq)4
zBUVe;mTGSN4yf~MQR?KY6WEEUX2xynSK3VQBnop|3ZC-tE)Vba at E#A3d3ckD$347V
z at lNPu*hG=k*hcKfu4mNrV`@ffK@<i_cQk$p9Q_8g7*`4_z}BOBx0NN%AIQXYTgq#!
zn>!htPSxEc$l>|OeY_J|N~LS(+{TO5-NO at j9&kCjp+`}Xk~B21!bl~?pE_BQNv5d8
zbjm@!v0{Jn?utyZM<s_dgY3fO*V%K4iL8aVN(bdpwGg8*4cegoh>4-5cOKrVuhoHr
z3kENT;Yfz}$phHO;YtQub^*M4J$9TR4o??Nt4dd|DqUffoq2-t*}iS#wvWcvt%LY7
zT>0@)=KAZ6IpYM3q!?oM*PO-2t9D+sYA3`aUhd*5zvsf<WSx1iF>0eNM}}d4o#|_w
z#lh7D=EXWwY at 7)4?mE-c*cIf-I&*vuo^ClbT2rE?sm>gY{TtW5G05vp)I{sd(!`s!
z+(68NF-zCaS9uKNqo#V?XzJkDm|0`W at j1@T>BaPijd?sVU*$1_Emdz8!?vo$7%t~Q
zWBRA(Wxcqv6^$8=jaKzU!HzRQ3kO%edXqBdN6}ZRn$HFMFvN{{)|^+ZCrodI1uO^M
zV0JoVYVKJE`oSn@@Mhd`VU%~^8iL_o`wKtJ-_f?YG%^4Wil!MJhupT0_l9!)ndWkC
zxNMs3F5Z2a<{hOH91r3_bGB4&r$|Rkb78QYYu<eGt=GWadv^CbGK~|*U<YgSEC#eq
z@>ZRYQ6+aV9Mh>&6SHu>J8Yu!@mJsw^Pxl2K+;zcueP*{7^QrpDuUBfa&tNCgykQz
zgCU%U)CDnrRK at 8z{{%6WjhSFUh?ha<1(Q#<T-BcLq&a;|CWd`oe<@&CFFO4c<-bv-
z*ZFrsyk?l>&<dCEAS#D|<;Sy(i^b*d0!AXRR}DX6!78$QS{BcDU3VzR>3i@%1f3p_
zb=gt;AdS~kR5(1u at t4hF`|)}bmVb%{qOYk)oj)Y^hDd15V17y|X^7Y{F{myQIJ>yc
z^;yUL<E%hGam^Vq*j_TU*n^1alMwcABtEKmH}OfucN3ph{4>OlDgHae=M{g9c)hCV
zKPC>>t(x#1;_Zqfj)?1mOcXKtF2b1afq=Z8vHVXh4=TR^5Xy6ZV)@H~p9k$8r%ri@
zl5Qd%BTm@#z>YqrQCC07kCNaYQU(us<i9}jT%Qk-{GSq^q~oo${X614bj;=W330;a
zcG|fR><+W@8V}#%;kSEuuZNd_V|^CMj#ach;F15bhyRg>|Fwtzy@&t1hcAayI;?&!
z_wWwjSgtu53a}qw=<>+lZh4(as_SXl@`y=NdZ)#h-zL6MaXYz_F64Ig!aQGTw>!-2
zD2YR!yRl0K2`f>9-27Dya#O7}$jye;ppdD0H)mKQ6|!m&vcwRwERb-Mc{R%Hq|`5Z
z#Uq{FGc+_3QUT$sA5J`^R<pmjm5}u2t=l%N-<saGY11t?ZclGtzhUc*Y1{PcOEA5k
zPQ!g?daxJfJ$nb!EwHxZI?l-89+*Y%&ky9w4#3Q5zIVj!Tl05i?LkeW)ULANVoon)
zU{`f|VIno*dQ&=6EcTC3wd98OW=i?JFxQTj;MBb}2Bv}&t*+UfxJ$YfZqm~*Kf4zp
ztihxc at zt&)-{KO(f<+;lfz<Ieu2Z at c0~uI0im#zO-4c{rYziqwbz;<3QLvby)1=jP
zxKphSxigusRCpT`gZ~rsfN`OVwpX%7!8?hg{H20#7yL58pCOL<;P}P*pCgWXaLi@S
zQ?Mv6^NrWJ1js)m<ng+P0Xg1-v7V0;NBvEL-zE4Jg7*nM%LLym<Yl>jSI9RC`Nsuc
zDfo=ggU=Lf=idsB&nnE13q6g3FN5m?1}vAf=K>GEfjDmPmXr1WI&rKwoPA_|zu;F3
z{`($|*F6lVN6LT4!(Z|6pL+Ot5vx9+|4I+v;Nf_E!=UZFUvPW|;d&So{A|JTx`#pc
z+eZYy1mal_-`}IW<VS@5bA<e>f}`^Q>-mA;vb}!d;fpXs2)exI3oiAn5FFERzLyIw
z<r5yhPVi=-=VOA)esZga-$fiZ^8C#Sd1=p}hu<T(v}eEI(w>Js{1M`~k at h?)<fT1d
z_wa8BF725ST-x(j9{v(>+(>&~5%SWWfA#PM!RtkPofKT!vxM#sb-!9p9Fs|VE)w$6
zo>hY5b3gaDs|A<x?s?9gcXFJ33DRP~d~vRY^&CeC0r`jFpZTZ7czdPb57GF8@>2g-
zJp5Z8{-THf(8Cwg`K$9?;o)mNe4B^w^6+m8F6-?D!DYR5LA_wW>bt=1xt~7TN6z;Q
zh(_ at T0&<=U!Q%=1fq?u2cF+Ax(mwKwXdgFIw2vIyg~K%MAjff)1J45>rztiYwG{yb
z+~EI()X#bpe;FGB!m#3##Cd9*_3R+d&*99^B|fe6e4Xm|nBtSf=N11P at p|e%tbaKj
zHz at u+O3(8HEdOW3Q%e3KI_^<?2gwgBzK!^V;`b1rRNT#<7;{+h`&>1fS;gJ_k1=zK
z<26_YjK(atk{ngHVcty~$21JgcM at OfaD^9%<2@<{mj5hqnl7&JL&Ujnv;4Efxlb~m
zBObHbtNKq6U#WNlwL6Zb7+6mmaU7E|FvsV53~{%q@P6WLiti`huJ~ib*C~F2cvA7D
zRPlw1mzj0FIHm7JBGDdik74-PeJ>8;4H|`{-6mn)7}jFk`r~VetZ%~UIZllyn^H3{
z2M5ct<b6TD7^g@7>9+UX(}%t-yn4GYo*H}3UR~w#Ejl+;eH-3x{Z#c^#TC~I=v%4r
zFC4 at M7;A8ORu{o%rn?{_B!OFI2Hz5v#U*bCXF6g15tUvCzpx?EeITnyEOlTQJVZ8=
z3(I1cjOCjk7M8Cmmes7NDugwErLekK&PtL2nN)yu1xR;*^aMyBm=~{@H=~R%rVex`
zQ!|}Zw1_L3y&i%C%P<$hHDYS);Hapo3fvzCC&Hj at KB}Th^2spCLt$_#3?2 at H(_!#v
z7@Q4*$HL%T7{oposHOQZxPVZ&bipBpQTzM<{^#xbPQ2^#d{aOzL$`>Pb~>dm$f?rT
zS5(;@x}^ThzA2}&2cOAg(Dnx6Pq#g9SKt3KdG at KHI$V4r>h`KGu+22joEy&Oisk%Z
z0R<MZPfuYmRvZE6XiLFm;XQ8a@4b3(-N-Jc^EvNO?V28SH;#h&@;ZC>Nnn&CXo~(`
z+MWdeop<cV^DemVm>3w0Hy5_xY&>j}wEs1FcHk&oeth0nB386J=2DE}1Std@*DxO*
zP8twGz<GA$y3XfGX<Qk`=`k$^oEHhp{}@gjK}eBe%pZ3-J?Ebwrt^=9=NJ&F1f7 at 9
zcZbu*Dk<HLuD?#eSbiOnp8T~et`}(AQ5UDbMJd+l@t7WOYb3kRafd0oAYn6p6#jMn
zalO_ghJ#6(XnK+pkbur#r<2E#(3-*WhLsq(zWO?Cr_*=FKAQ+5vHxJsO{!qnuE>*$
z-%7k&@m<7=ijNTAulP9eNyWcNd|L4*h|ekh3~}8FULekMSN0HoUM0?RSIp5z2Fu%}
zI@8%Uzlh<v8<vj|pHT9x#Ch(9<=q-$#7rysPm=tc;^;er_ADrVFLCV?_&MTDs%w3T
zcvA7h#Jd%Db9hi*#oe4=#PFOBm+KAEGpXbkS-T@<N^$hT!Ezl_{7T~UieE>(UJYEX
zogyZtc$Vbb72iv|OYt${eTqLqd{pr#h#yq^+r-&dkLw40bFjQemHctybBd#Hj%|0v
z&$0CqF;O){G!k!8+|A*^`K$P5lJ8dBtzAO9D?UK-`xPH0KB at S_#1AX}W#Y4ne}njO
z#a%5d#!XFl9^}J(+;B}3?`3p21L`r%#|`Js(RXQzlJH|y3-L+CyNORIj{O7m^bo&{
z48S!z<XuW0*V>RL6+Z*Yudl7B>Kx!GA6N2giN_TG6!ECy_YntGHgI_#BR=o2^>4u4
zqr~SF|1t0|JL}*+2ko3y@|O~yR(vDzDaA9yCl!B?_=Mt55+7CkW#UD}|C4wZab5?C
zL07ZwqU6^Tk1M{5cueu%A|6%zN#cYn_52cWmgP9yzTx4^;C>`b{$k*0|1`DlKihG{
zn1n}uorkA9{B{rTwY<*g`|NuyhwB&g7a0x`KcTpFJ^Jr``l^q}>9q5NlEgVYNfLZ_
zI{0>L at Fm^gJH^5Ge1mV)2HzVdPd;f-B4~9YXg0Zy)g%lWo(Ni=2%1hGHmK1RG(O}#
z?Uvw6#VtYWL*52&3D$Z`(A1E((L>%oZwc0XOVIj|x8KQ~P8Pd0Xnkw2?puS_w+8FJ
zHCQ0}ghNe^LF+ at l6VMv$Ic>qZZwp!<@)d)&p!Ff&L<sqqLR+xsv<0ni3)X#G(E8Ou
z>y-nmtR(gJb~Vb52h~IS!G~Y|FG5H+T3Pt&*Cc-Fz78QBjb)L=*D2onQbceJ`akrg
z2)|!;mvD*h&E)&<&X?h%9dWvJ;wLQF5nJ|*s?)Obgm$+M;AcLVb;IOM-~yet4%!`b
z9ZTETn*)PNjeE1q!wy;O-7F*Iw;=Go#y-Bl7Uz-L;h%lL_&r(VYX#@$1LQdO#`3MO
zj{*5=_-EdU5CU@auVBveV#v{tf_Vw{F(5~s%pX7q0Xe=e#r$D}5Rl_s5c5Y7LO_o9
zzRaIQ2m$#=;Gg*sgb<KRpTqB3>i9LV&+^|F{A$796ddPPS>CQ7!!hc|sZr+3>3$da
z6 at p(Tc$466e#Ytfu;86S{&K- at 5qy>4y9BSPf8y|%XWu(wJ0BMED}|m%1;0%2Ck4M$
zaQ5-W^4=-<^CI6*3I3|!cM1Ljp<mknA3{DY<fHUFf%!HH&c0p9rJhwnUh+1<@qIq7
zpKAq|@|y&gKKVBZF6DQ7xb!)XiG11jO56W=p$DBQ*v>x?T;}^#!7mZ=Q-VwRrv;b3
zpl%+?^-n4P=RzKzS=pW!1efwJ3ywaJEdNh}OZhhh$F&8P=lMrnKamIsK|qdE<t)EM
zaH*f?CAFSS9{EoQj=rF*pXV#Jo?am at eR|#eRj@wy33>FpWBt-sU)nz*<d+Ni&kHW)
zza;p1LjG~VrTm`=j%y-p&ohEc`M(ex=L1;&Zv>a}{~)-0_vCfKrM&d{$E6h3Z*X9P
zpzHq}!R5OQ?-yL^zf5qPi(>s(3NGb&J{R-Fr6rcX!6Sc@;JEg~^4kTM`q{@8_2WOw
z=RNXw3l38n75UEyF7<y_aG2Vu$jf&Dq&(`xfXO}y|7;Jh`)Q8XI1HNOJqZTQQw|6C
zu!ryW at Pi(H$iokN_)!l(=HbUZe8I!(#dWQwK0Tb*!*sp1d*o9d&g*1a&q0s;ArE)!
zHNke|d0tF*9hDt7Y(Mhr1y7QG+}t2I+lf3Wcu~l&7kt0q8w8&eyi@Qg!8Z!d^OYDa
z<!6QbjY57-a4A18_$DFG>w*})S#Vw#M4l2nPS-)?Qh!qLEkfR{L%B8Zj|tu*<UcNW
zQE(|gD)?3*KOy){g7f+!+Ih3!(?VX_KP&h)AwMU0m*9NeNBy4=JQ{Ha$bVIEzP=;B
zMewAM-!3>`$5Gy`DZ9v`kpDFy&+CpTf1BWoU_KuMa{Eu^i7Ng&MnZ at w&i$<DzU${4
z%fVy(RNwV$O}zc@`o(Y%ppdlNBz)CxG5C4f$?()T`0wJqCU_$6>x0krRa}b4_ElnL
zI_*dUu?<z>A{@r5hu~g2+*CaT|6cIaWzA2IVg}>G6^&z0?{_3wm6>n^e1*xLr*WKz
zRG^E=q$Ax`a>$XMDw%Qw3d5;z{0BW?F_$z3hhQ-ug5ifptq>=fwnvAZl?;zM=nQ2z
z>!7oh;V}m%?S|o;gU(`x#~pM=6TBA8aW=Emypx)?8-@!GI;#lotB17CBqmWH&K at Sv
zFo)-)s(ncy&Jvbs0OE3G0+oKyW$Aj(Sa%P<J^;GRDE_<`PEiA+9RG9ry5SsA*ypNF
zyPI1K48`G#hAuYSBx#SIg*hV1JGAxrxJB_s7eWJ#x%IG*`QR2qgWFgiHRL2l6yCF=
zvG#l#TRB1ua~9$J4(inD`8^;`$6K8q=cO<U%8tb<z9q2=aXY&Fc>kkJw1TtRAkw2{
z at p&vvl+(-WFRIY#!)!;nNor8O7sTekdeZfeJS_iq5_}QjWzhM{IK3YUSnDMGK5Dvk
zSl*6AHR_!mLGIe;%+Pi0Fkd&ECkpfVz<Jd$pAWph3G?~5130dcbKvu)VC9)sw-0*w
z!<N?>PR}X6YB_vQshWk2`WEq}io1#HpXoa`r{VL*{%QE?{I<1-zjFc~7=bTo^CWnM
z)=Z68sGJw)zKZ=;&IRB;2ITUY{1Qup9Oq{-XnFMG#Gv^WhXcIZ!*_YO^H~h)cRq_j
z{zZ?TCp`Qa5C5)*|D%V$<>6;hKhyQo;NjPJ_y!NZ&BL9~Vz7Sh^T_|6hkwPxzv<zB
d>EYk^@E?2lV!FWSdi#KfU*+M>XE9h0{{@r-h|K^1

diff --git a/python/coccipython.cmxa b/python/coccipython.cmxa
deleted file mode 100644
index 063b44c55bde522d39b09c2779d49fd78268e8d6..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 2575
zcmZ=x%*`>hw6u&eFf?eHx@;c<1Lu1N2F4l&2G$)63@ocRELgz7z@WjP9Z;E^pPZZ-
zpIBPK!nlBi$zj0)b>GCI;*7)`gWkG)>D~uxN^hO!o_RM~Uw^>@6`#!F5`#Idza8fW
zt at zuX(^BDF^58sB+`l-r#Go%_j&q}&>}Q8(-<|H{J$t-hfm%ROW?o5}L8vN^r5x*m
zsh2Y|CS150vS`5qRsW<cpqAyz$2A)xr|G;9@o4)N@%6)k1^WK!MTrF&@u?Lhsd*`>
zDF)kZHdH?iJovXgSyPUEgX~nGsXnO{nR)33wPDIfec7Tee+yERRWF-52k4IA)RH8F
z$$PhUh-3*1W&gVJYTMB!HlU8+5}-rU4cJ!4Wx5<GR@!-)^}s4__WwY40CfbE7;Kxv
z%-6GA{A$?cn|rllmHsYRpcRywo?1~5UtCgTz<#35qRwvtYlf;>-7yc3`wJFm`zPn;
z<fJB-Waj4?RBdgqH7&Cblk4s)o@~Zz0JP7kG%YQ)$iQKLs=m@<tD0Y|?_{q&xc+3p
z0=<Bu)RL0Q_ySPC#3vhUj63c!SD=6EUh(c0-nljn3l=B?-D<G^+GUAuPv*oW*Bvig
zW>qZ!8tI&$n+vooF8gFJ-)pslyiejg+pkS70(!x*7-Uj^!B6`shp+z4$a?-nGK4V>
z7?C0Q*{OLzsj4ig2anWV*)V!qzMQo9aXrv9i0=$$Z at uww+6IT+=QUzZy>0u?0Sv;>
zyvzy%Ey+o<f<xTj^7J3=dc5`^(0;9u%7WB*aAGm&x0|AOuBpXMTCPwk;K8HaK&w0w
zi!(}+at!9QeK%qix>mwf%2<CbF>D3UD*wdd;{0TTddZ2L_R7as`|$nSbRw?f4bb79
zc_qe11}9~>ch4^?*vNB-U-wM-(VxH|045FttJlUCMT}2IZ&L_97MA+D3 at Gealx~pl
z==8?-)?L-V at 4PO3{dtuk&}9LsMP-S_nPsWP2Dgi>#Aj?&deAAkX#ZO_RS{rJA*FBw
z_VerH-t=p6tyqv8Iy0p16evX}R#h6TT9U-*#`{QVhtR1{-;$GDfZ8BomzbBAUt(}b
zX+>dR(vv&Sj`W>4JcZpA7>&;Pc_l^pIq_*Z`Q^Y6zOi7F#uJtWA~&wCjqbSf?9PG(
zn&4Og<t>8~XGH54uAfx7KS3kg^GDBONIK0lh?O{S?dbCJ<y)SA{UmgKg)%Vj!D89Y
z)pJYDB0u+7hf~5YSsjIeGSIA4^`2!><;U#hlNK>PEs0k<jOzb&e;oo{l7#N4i{5pO
z2tVVAnc%LL*)Cbg{e303xqZn5?f76&5P&lE)cm(>vuzJdn6QAmhVR3gqd*&>nMP8A
zOLfbN4#g=YPioA&Qu5&`?!<ilYPGw@v)<Y-*x=*obJxLPfy)9XhXqaxoE;n-3^e6c
z>qCooaTRWw at QHIen<cc!(elfWFMyOfuo4G%h9(eu1Y!vmnwWV8cLv3un(*fWScqX3
zGq`dU?tG~1n^<5lU20-XY+mKAo~Tec_Vlk!IP(Cmf*EJofH!&KFZ)<r3?ldGc{jd#
zz$ABod78xH%DXsAEj&dKo+1Np4TLSf0&@;>ykX`7Sj=FiWpFr8eK}v~QDXf$=~JS*
zFC>M7p(z=Ziu+EMEt=>lClt at IBfp+G=?XLzt3!*G(Ih-zNf;Id2ATZ9cK;SWyqa<E
z@c$d3=Z*st1EP$<l2$25`#36RIwo@@pP?sBU~&be*uP=2AA&nhX&s9BxTm{?$pk0{
E0D4P+lK=n!

diff --git a/version.ml b/version.ml
deleted file mode 100644
index d27801b..0000000
--- a/version.ml
+++ /dev/null
@@ -1,2 +0,0 @@
-let version_date = "Mon, 19 Aug 2013 10:40:00 +0200"
-let configure_flags = "--enable-release --disable-python --disable-pcre-syntax"
-- 
1.8.4.3
