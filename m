From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Mon, 10 Jul 2017 17:12:25 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!3b412209b28e186e2cf1ceaaa46d40e6d1947012ed574b129f9c461a255f53e26f88920405ecdf4a7d052d70724bc64e!@mailstronghold-2.zmailcloud.com>
References: <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
 <20170704174632.v7ibsesdtquktbjs@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041948510.3327@hadrien>
 <WM!afea88a820c9c853667fab8a120e0e62e64bc1c9aacab0e42f4149cedda4906e7b85ddc1f742afe16ea78098b42a61f6!@mailstronghold-3.zmailcloud.com>
 <20170704191736.rcghven7t3ol5ih3@eos.mistotebe.net>
 <alpine.DEB.2.20.1707051420260.3050@hadrien>
 <WM!da212a33f363d5e8666de4eea7afef6ff657b4ba0eea72f6c914a365ab717eec189b136e17bf2c01cc76cdde89f25962!@mailstronghold-2.zmailcloud.com>
 <20170705162516.jyqinnwnfqjwuskg@eos.mistotebe.net>
 <alpine.DEB.2.20.1707052234030.3445@hadrien>
 <WM!3b412209b28e186e2cf1ceaaa46d40e6d1947012ed574b129f9c461a255f53e26f88920405ecdf4a7d052d70724bc64e!@mailstronghold-2.zmailcloud.com>
Message-ID: <20170710161224.rbqo4drhcfqosh23@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jul 05, 2017 at 10:38:32PM +0200, Julia Lawall wrote:
>> @@
>> format list[5] five;
>> expression E, A1, A2, A3, A4, A5;
>> @@
>>
>> -Statslog( E, "%@five@", A1, A2, A3, A4, A5 );
>> +Debug( E, "%@five@", A1, A2, A3, A4, A5 );
> 
> The problem is the macro LDAP_PF_LOCAL_SENDMSG_ARG that is used in
> contexts like:
> 
> 	c = connection_init( sfd, (Listener *)&dummy_list, "", "",
> 	        CONN_IS_CLIENT, 0, NULL
>                 LDAP_PF_LOCAL_SENDMSG_ARG(NULL));
> 
> Note the lack of a comma after NULL.  Putting the following in a file
> con.h:
> 
> #define LDAP_PF_LOCAL_SENDMSG_ARG(x)
> 
> and then using
> 
> spatch f5.cocci -macro-file-builtins ~/incoming/con.h ~/openldap/servers/slapd/connection.c
> 
> gives the expected result.

Thanks, good thing is make test now seems to pass for the first round of
patches.

Actually, I'm now having a similar issue with ./servers/slapd/daemon.c,
spatch --parse-c will complain about the SLAP_EVENT_DECL macro and I can
see other issues with LDAP_LIST/LDAP_STAILQ/... macros in the output.

This patch is the one that's affected (among others), it will make some
changes, applying them and then running it again will make more until
eventually managing to pick up most or all of the ones that I'd expect:

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0, 0
 );

@@
expression E, S;
@@

Debug( E, S
-, 0, 0, 0
 );

Is there a way to work around that somehow?

Thanks,
Ondrej

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
