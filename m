From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 22 Sep 2015 15:09:41 +0200
Subject: [Cocci] [PATCH] Coccinelle: remove incorrect -include option
	transformation
In-Reply-To: <alpine.DEB.2.10.1509221453541.6225@hadrien>
References: <1442926130-17817-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.10.1509221453541.6225@hadrien>
Message-ID: <56015315.507@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/22/2015 02:58 PM, Julia Lawall wrote:
>
> On Tue, 22 Sep 2015, Andrzej Hajda wrote:
>
>> kbuild/gcc uses -include option to include files and -I to provide paths for
>> #include <> directive. The same is true for spatch.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  scripts/coccicheck | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index bbf901a..6d84b05 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -30,7 +30,6 @@ FLAGS="$SPFLAGS --very-quiet"
>>  # spatch only allows include directories with the syntax "-I include"
>>  # while gcc also allows "-Iinclude" and "-include include"
>>  COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
>> -COCCIINCLUDE=${COCCIINCLUDE//-include/-I}
> I'm not sure of the meaning of the above notation, nor what is the
> intention.  Coccinelle does have a --include option, but it doesn't mean
> the same thing as -I.  It is a way to have a file be included that is not
> included according to the normal inclusion strategy.  For example, if a.h
> includes b.h which includes c.h, and if one considers that c.h is really
> important for having the right type information, but one doesn't want the
> cost of including everything via --recursive-includes, then one could put
> --include c.h.

This option has the same meaning for gcc.
But the patch is incorrect. It should be:

COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}

gcc option '-include' should be converted to spatch option '--include',
ie one minus should be added.

Regards
Andrzej


>
> julia
>
>
>>  if [ "$C" = "1" -o "$C" = "2" ]; then
>>      ONLINE=1
>> --
>> 1.9.1
>>
>>
