From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 10 May 2016 20:14:19 -0700
Subject: [Cocci] remove redundant const qualifiers from function arguments
Message-ID: <20160511031419.GY3766@xsjsorenbubuntu>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to remove 'const' qualifiers from function arguments that are
passed by value.

e.g. I want to convert:

void foobar(const int bar, const int *baz);
to
void foobar(int bar, const int *baz);

I came up with this semantic patch:
/* Remove const from arguments passed by value */
@ rule1 @
identifier fi, I;
type T;
@@
 fi ( ...,
-	const T
+	T
	I
	,...
 )
 { ... }

That seems to work fine on function declarations, but does not cover
function prototypes. Extending the patch to function prototypes I ran
into some trouble. As complete separate patch, I evolved the above to
(just replacing the function body with a ';'):
/* Remove const from arguments passed by value */
@ rule1 @
identifier fi, I;
type T;
@@
 fi ( ...,
-	const T
+	T
	I
	,...
 ) ;

But that is not parsed by spatch, causing this error:
  init_defs_builtins: /usr/local/lib/coccinelle/standard.h
  minus: parse error:
    File "const_proto.cocci", line 9, column 1, charpos = 115
    around = 'I',
    whole content = '     I'

Also, using the first version of a patch on a c-file with matching function
declarations that also includes function prototypes, results in both,
declarations and prototypes, while using it on a header with prototypes
only doesn't result in any replacements.

I attach the patches and some test files for reference.
const.cocci apparently correctly removes all const keywords from the
test.c file, but does not change the .h at all (which is correct, just
weird that it changes the prototype in the .c).

The const_proto.cocci file causes the above-mentioned error.

Does anybody know what I'm missing here?

	Thanks,
	S?ren
-------------- next part --------------
/* Remove const from arguments passed by value */
@ rule1 @
identifier fi, I;
type T;
@@
 fi ( ...,
-	const T
+	T
	I
	,...
 )
 { ... }

-------------- next part --------------
/* Remove const from arguments passed by value */
@ rule1 @
identifier fi, I;
type T;
@@
 fi ( ...,
-	const T
+	T
	I
	,...
 ) ;

-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.c
Type: text/x-csrc
Size: 635 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160510/24ef54e3/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.h
Type: text/x-chdr
Size: 46 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160510/24ef54e3/attachment-0001.bin>
