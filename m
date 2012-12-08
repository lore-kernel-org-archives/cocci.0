From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Sat, 8 Dec 2012 16:13:47 -0200
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/semicolon.cocci: Add
 unneeded semicolon test
In-Reply-To: <1354988739.3198.3.camel@joe-AO722>
References: <1354988074-2165-1-git-send-email-peter.senna@gmail.com>
 <1354988739.3198.3.camel@joe-AO722>
Message-ID: <CA+MoWDr0JT0T-0ZUDsqceuXKbjW_mavS9t6HGkFR4dz2XUygWg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Dec 8, 2012 at 3:45 PM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2012-12-08 at 15:34 -0200, Peter Senna Tschudin wrote:
>> This semantic patch looks for semicolons that can be removed without
>> changing the semantics of the code. The confidence is moderate
>> because there are some false positives on cases like:
>>
>> b/drivers/mmc/host/cb710-mmc.c:589
>>                 break;
>>         case MMC_POWER_UP:
>>         default:
>> -               /* ignore */;
>>         }
> []
>> diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/misc/semicolon.cocci
> []
>> + at r1@
>> +statement S;
>> +position p1;
>> +position p != {r_default.p, r_case.p};
>> +identifier label;
>> +@@
>> +(
>> +label:;
>> +|
>> +S at p1;@p
>> +)
>> +
>
> I believe this also fails on this case:
>
>         void some_func(...)
>         {
>                 ...
>                 if (foo)
>                         goto exit;
>                 ...
>
>         exit:
>                 ;
>         }
>
> where gcc needs a semicolon after a label before a function exit.

No it does not fail. This issue is switch/case specific. See how I've tested:

$ cat /tmp/test.c
void some_func(void){
        int *foo;
        if (foo)
        goto exit;

exit:
;
}

void few_func (void){
        int a;
        switch (a){
                case 1:
                        a=1;
                        break;
                case 2:
                default:
                        ;
        }
}

void main (void)
{
        int a;
        some_func();
        few_func();
}


$ spatch -D patch scripts/coccinelle/misc/semicolon.cocci /tmp/test.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /tmp/test.c
diff =
--- /tmp/test.c
+++ /tmp/cocci-output-2570-defed8-test.c
@@ -15,7 +15,6 @@ void few_func (void){
  break;
  case 2:
  default:
- ;
  }
 }



>



--
Peter
