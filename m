From: Nikolaus@rath.org (Nikolaus Rath)
Date: Mon, 10 Oct 2016 14:27:11 -0700
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <alpine.DEB.2.10.1610102144590.3438@hadrien> (Julia Lawall's
 message of "Mon, 10 Oct 2016 21:45:54 +0200 (CEST)")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p3jwr3.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080727090.3176@hadrien>
 <87ponay35u.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610082317180.3373@hadrien>
 <87wphhz1x5.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610100653510.3148@hadrien>
 <877f9gqjsn.fsf@vostro.rath.org> <87shs4oxeh.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610102144590.3438@hadrien>
Message-ID: <87k2dfq4i8.fsf@vostro.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 10 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> I claimed success too early. There are still the following cases left:
>>
>>
>> static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
>> {
>> 	struct fuse_session *f = req->se;
>> [....]
>>
>> I tried to adapt the rules myself as follows:
>>
>> @@
>> symbol f, se;
>> @@
>> struct fuse_session *
>> -f
>> +se
>> ;
>> <...
>> -f
>> +se
>> ...>
>>
>> @@
>> symbol f, se;
>> expression expr;
>> @@
>> struct fuse_session *
>> -f
>> +se
>> = expr;
>> <...
>> -f
>> +se
>> ...>
>>
>>
>> @@
>> identifier fn;
>> @@
>> fn(...,struct fuse_session *
>> -f
>> +se
>> ,...) { <...
>> -f
>> +se
>> ...> }
>>
>>
>> But this gives an error:
>>
>>
>> Fatal error: exception Failure("meta: parse error:
>>  = File "se-rename.cocci", line 14, column 7,  charpos = 79
>>     around = 'f', whole content = symbol f, se;
>> ")
>>
>>
>> What am I doing wrong?
>
> What version of Coccinelle are you using?  Before 1.0.6, it was not
> possible to declare something to be a symbol more than once.  In any case,
> once it is declared as a symbol, it is always a symbol.

Ok, we're getting there. I've removed the second 'symbol' line, and
(permanently) updated to 1.0.6. However, now it seems to simply run
forever:

$ ../coccinelle-1.0.6/spatch.opt --sp-file ~/in-progress/libfuse/se-rename.cocci --in-place lib/ include/ test/ example/ util/
init_defs_builtins: /home/nikratio/tmp/coccinelle-1.0.6/standard.h
warning: patch output can only be created when only one
directory is specified or when the -patch flag is used
HANDLING: lib/fuse.c
(ONCE) Expected tokens fuse_session f
Skipping:lib/fuse_opt.c
HANDLING: lib/helper.c
Skipping:lib/mount_bsd.c
Skipping:lib/fuse_loop_mt.c
Skipping:lib/fuse_loop.c
HANDLING: lib/cuse_lowlevel.c
diff = 
[...]
HANDLING: lib/fuse_lowlevel.c

At this point it has been hanging for about 15 minutes now, steady
eating CPU time. 

Is it supposed to take that long? The fuse_lowlevel.c file is 74k with
2465 lines of code.

Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
