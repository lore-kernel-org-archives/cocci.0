From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 11 Jul 2017 14:06:41 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
References: <WM!da212a33f363d5e8666de4eea7afef6ff657b4ba0eea72f6c914a365ab717eec189b136e17bf2c01cc76cdde89f25962!@mailstronghold-2.zmailcloud.com>
 <20170705162516.jyqinnwnfqjwuskg@eos.mistotebe.net>
 <alpine.DEB.2.20.1707052234030.3445@hadrien>
 <WM!3b412209b28e186e2cf1ceaaa46d40e6d1947012ed574b129f9c461a255f53e26f88920405ecdf4a7d052d70724bc64e!@mailstronghold-2.zmailcloud.com>
 <20170710161224.rbqo4drhcfqosh23@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101816540.1968@hadrien>
 <WM!18ce1dcc914ca4f9b61f6c3aaf891296df9651e3b4d79666e0682dd2ff392a761c732ee0cf4f6500e93b392f83991daf!@mailstronghold-1.zmailcloud.com>
 <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
Message-ID: <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 10, 2017 at 07:26:36PM +0200, Julia Lawall wrote:
> Try running spatch --parse-c on your directory to get a list at the end of
> the top 10 things it doesn't like.

One of the system dependent macros SLAP_EVENT_DECL is listed in each of
the 10 things. The macro is used in
https://github.com/openldap/openldap/blob/master/servers/slapd/daemon.c#L2343
to declare some variables used in the corresponding event loop.

The macro definition looks like this:

# define SLAP_EVENT_DECL		struct pollfd *revents

or:

# define SLAP_EVENT_DECL	fd_set readfds, writefds; char *rflags

Ignoring this macro is OK I guess, if there is a way to do that with
coccinelle?

Also, moving onto the other patch, I get similar inconsistencies with
./servers/slapd/back-sql/add.c, --parse-c doesn't list any problematic
statements but the output logs a few parse errors that don't make much
sense to me.

Thanks,
Ondrej

> On Mon, 10 Jul 2017, Ond?ej Kuzn?k wrote:
>> On Mon, Jul 10, 2017 at 06:18:14PM +0200, Julia Lawall wrote:
>>> On Mon, 10 Jul 2017, Ond?ej Kuzn?k wrote:
>>>> Thanks, good thing is make test now seems to pass for the first round of
>>>> patches.
>>>>
>>>> Actually, I'm now having a similar issue with ./servers/slapd/daemon.c,
>>>> spatch --parse-c will complain about the SLAP_EVENT_DECL macro and I can
>>>> see other issues with LDAP_LIST/LDAP_STAILQ/... macros in the output.
>>>>
>>>> This patch is the one that's affected (among others), it will make some
>>>> changes, applying them and then running it again will make more until
>>>> eventually managing to pick up most or all of the ones that I'd expect:
>>>>
>>>> @@
>>>> format list[2] fmt;
>>>> expression list[2] args;
>>>> expression E;
>>>> @@
>>>>
>>>> Debug( E, "%@fmt@", args
>>>> -, 0
>>>>  );
>>>>
>>>> @@
>>>> format list[1] fmt;
>>>> expression list[1] args;
>>>> expression E;
>>>> @@
>>>>
>>>> Debug( E, "%@fmt@", args
>>>> -, 0, 0
>>>>  );
>>>>
>>>> @@
>>>> expression E, S;
>>>> @@
>>>>
>>>> Debug( E, S
>>>> -, 0, 0, 0
>>>>  );
>>>>
>>>> Is there a way to work around that somehow?
>>>
>>> I'm not sure to understand the relation between the macro problem and the
>>> need to iterate.
>>
>> The above patch will make some changes but not all (even though the
>> patch is idempotent) but iteration seems to help. It seems that it's
>> because spatch does not like the file (or rather some of the macros
>> there).
>>
>> --
>> Ond?ej Kuzn?k
>> Senior Software Engineer
>> Symas Corporation                       http://www.symas.com
>> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
>>


-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
