From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 28 Oct 2017 20:26:48 +0900
Subject: [Cocci] [PATCH] coccinelle: fix verbose message about .cocci
	file being run
In-Reply-To: <CA+r1Zhhy_kbW_EwruY9n_0LCccEfFaOdfk5Jhn3NN2vwyNhuTA@mail.gmail.com>
References: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+r1Zhhy_kbW_EwruY9n_0LCccEfFaOdfk5Jhn3NN2vwyNhuTA@mail.gmail.com>
Message-ID: <CAK7LNASRB9jt7M==4fCZvOrHpv3bsEuQP9Ta96xyibAAnXi9ug@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Jim

2017-10-28 8:56 GMT+09:00 Jim Davis <jim.epost@gmail.com>:
> On Wed, Oct 25, 2017 at 9:55 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> If you run coccicheck with V=1 and COCCI=, you will see a strange
>> path to the semantic patch file.  For example, run the following:
>>
>> $ make V=1 COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
>>   [ snip ]
>>  The semantic patch that makes this report is available
>>  in scriptcoccinelle/free/kfree.cocci.
>>
>> Notice "s/" was dropped from "scripts/coccinelle/free/kfree.cocci".
>>
>> When running coccicheck without O=, $srctree is expanded to ".", which
>> represents one arbitrary character in the regular expression.  Using
>> sed is not a good choice here.  Strip $srctree/ simply without sed.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  scripts/coccicheck | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 1bfa2d2..9d18662 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -186,7 +186,7 @@ coccinelle () {
>>
>>      if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
>>
>> -       FILE=`echo $COCCI | sed "s|$srctree/||"`
>> +       FILE=${COCCI#$srctree/}
>
> [jim at krebstar linux-rc]$ make CONFIG_SHELL=dash V=1
> COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
> dash ./scripts/coccicheck
> ./scripts/coccicheck: 63: ./scripts/coccicheck: Bad substitution
> make: *** [Makefile:1585: coccicheck] Error 2
>
> --
> Jim


Did you review/test this patch?
or point out something about existing code?


The error message points to line 63:
COCCIINCLUDE=${LINUXINCLUDE//-I/-I }


My code
FILE=${COCCI#$srctree/}
works on dash.
I believe your post does not block my patch.


Actually, scripts/coccicheck contains three lines
that depend on bash.

line 63: COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
line 64: COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
line 134: if [[ $? -ne 0 ]]; then


They are legitimate because I see the correct shebang #!/bin/bash
on the top of this script.


CONFIG_SHELL is not described in Documentation/kbuild/kbuild.txt
so Kbuild does not expect CONFIG_SHELL overridden from the command line.
(at least for now).



Some sell scripts in kernel tree are specified with "#!/bin/sh"
and others with "#!/bin/bash"
Both of the cases are invoked with CONFIG_SHELL in Kbuild,
so several scripts give error with CONFIG_SHELL=dash.

For example,

masahiro at grover:~/ref/linux$ make CONFIG_SHELL=dash tags
  GEN     tags
./scripts/tags.sh: 159: ./scripts/tags.sh: Syntax error: "(" unexpected
make: *** [tags] Error 2


Of course, it will be possible to improve this situation if we like,
but should be discussed in a new thread since this is
about Kbuild infrastructure, not a coccinelle-related topic.


-- 
Best Regards
Masahiro Yamada
