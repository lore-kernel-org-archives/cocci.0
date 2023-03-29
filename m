Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE7FC6FD18
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 07:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ShwHsB/KkELwzyEZDwa4XqP7hPtXAant2Ydr/uTw7CA=;
  b=oC4XmyshddGPkGUtMGdzr57M2wpra5APaBx+j68hk1UwkGaHeXdMFkr/
   RP/NVDaoe5EIkDkqqFJ1J80JZeEvbkVVVS3hXPvNJ2tXjKtOEma6PpX/b
   kzo1EY7xhVEBjCFHy0Kyc//gnU7M8q7CBvUfTVYr4BSlgj+Lq+Yfq6e7J
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99631777"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 09:25:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 482A6E0B50; Wed, 29 Mar 2023 09:25:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 55FF3E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 09:25:48 +0200 (CEST)
IronPort-SDR: 6423e7fb_GSKHfhigMMEm9MJ9ikGmLn9FMJULvS/D9exMSuGUrLjJvUD
 YaNIMKSlu8CaC1s59OhQDY+kny5+Xj7IAq8HWEw==
X-IPAS-Result: =?us-ascii?q?A0EkAABT5iNkmB3ch8NaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItdVUwBAtGhFORAS4DgRODHJdPgVaBfg8BAwENRAQBAQQDhH4ChTkCHQcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEBAQEBF?=
 =?us-ascii?q?QkZBRAOBSKFaA2CNykBgXwsDVJ3AQEBAQIBIw8BDQEBOAQLCxgCAiYCAlcGA?=
 =?us-ascii?q?QwIAQGCegGCOSMHrRR6gTKBAYIIAQEGnS0dgV4DBoEULQGNBIM2eicbgUlEg?=
 =?us-ascii?q?RUnDIJANz6ELiuDQ4JniX6EIYsvgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZ?=
 =?us-ascii?q?AsOcYFKAmRMX0IlBA4DGSsdQAIBC3U/NQYDCyAGWGsCCSMREwUDCxUqRwQIO?=
 =?us-ascii?q?QYbNBECCA8SDwYmRA5CNzQTBoEGCw4RA1CBRwQvgVoKBkudZwEBej9GWl1Rk?=
 =?us-ascii?q?kuOf6IMhASEOpU/hngGDwQuhEmSPw6SKZdqIKI8EoUsgWkBM4FcMxoIMIMiT?=
 =?us-ascii?q?wMZD44gGYQBj1NCMTsCBwEKAQEDCYhrglgBAQ?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNhq6M/P8I0XFZqNQP8=
IronPort-Data: A9a23:lhjraqpBpz3J4juE89fACshbwZBeBmJzYRIvgKrLsJaIsI4StFCzt
 garIBmHMvuJZ2Twc4hwbYWy/RsO6J6DmoVrTlNurio9QnxG8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGj9SuvLrRC9H5qyo42tD5A1mPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2k2Br8Dq8ZQMVhI2
 sVEKB4pYD6jwLqplefTpulE3qzPLeHwOZ8H/3Z90WufFus9TNbPTs0m5/cBjWp235sTW6yEP
 4xDOFKDbzyYC/FLEkkdAZg9lc+zm2LyNTZKwL6QjfduvjWKnFUguFTrGNGOX9+zau5ypGizo
 2jlrl/2Oj47OcPKnFJp9Vr32rGfw3mmMG4IL5Wz8fVhgXWI12kLAVsXU0G6qL+3kCaDt8l3M
 EkI4m8psLRosle2VdS7UxDQTGO4UgA0W+FiCLwazzG0zIXtvwa3ImYqbnkZd4lz3CMpfgAC2
 liMltLvIDVgtryJVH6QnoupQSOO1Ts9cDZYNH5fJecRy4i/8dhr5v7aZow7SMaIYsvJ9SbY7
 x3ikcTTr64WkdZO0Linpxbcnimh4JTEJuLU2uk1dj34hu+aTNT+D2BN1bQ9xaoZRGp+ZgXZ1
 EXoY+DEsIgz4WilzURhutklErCz/OqiOzbBm1NpFJRJ323zqyb7J9AKvWgmeB8B3iM4ldnBP
 B+7VeR5uM87AZdXRfYtM9rZ5zoCncAM6ugJptiPMoQePMIsHON21DpzfkPYxGfjjFcli6x3I
 pCfbNqtCnABQatq1j+/QfZV3rohxkgDKZD7G/jGI+Cc+ePGPha9EO5dWHPXN7BRxP7a/G39r
 ogOX+PUkE83eLOlPUHqHXs7cApiwY4TX86m8qS6t4erf2JbJY3WI6SMnuN8Jtc/wvQ9eyWh1
 ijVZ3K0AWHX3RXvQThmoFg6AF82dcYi/SAILmY3MEy22nMuR4+q4e1NP9E0ZLQrvqgrh/J9U
 /BPKY3KD+VtWwb33W0XTaD8i4h+KzWtpwaFZBS+bBYFIpVPeg3u+/3fRDXJyhUgNCSNiJYBk
 +WS7T+DGZsnbCZ+PfnSc8Oqng+Qv2BCuedcXHnoA9h0eWf+/LhMLwj0qKEWIt4NGzrH1DC1x
 wabOjZGhOjv8qse0sjFurCAlKitS9BBJ0t9G3LKy4q2OQ3x3HuR8aUZXMmmJTniBX7JooO8b
 uBr/tTAGfwgnmcSlbFjErxunJkM1/G2q5B0lg1bTWj2NXK1AbZdI16D78lFlotJ4pR74QKWe
 Ea+yuN2CIWzGvHOMQAufVI+T+G5y/srtCHY7q01LGXE9SZHxue7fnsIDSacqh52DeVTANs+z
 PYDqfwmzVW1qiAXP+asigFW8GWxLUI8bZg3i6FCAKHXp1oq7npgfa3jDjTH5cDTStdUbWgvD
 DympIvDoLV+1EDySWUXKimU0cZ8mJ9VhgJ49wIBFW+ogfvAvOc8hzdKwAQ0TyNU7xRJ6P1yM
 W5VLH9IJb2C0jNrpcpbVUWuJl1xPwKY8UnP1Fc5rm3VYE22XGjrLmdmG+Ky0G0G0mBbJB53w
 aq5zTv7bDPUY83B5Cs+dkp7ofjFT9Yq1AnjmtiiLvuVDasBfjvpra+/V1Um8yK9L5sKu3TGg
 u128MJbS67xb3cQqpJmLbiq7+0bTRTcKVFSRf1kwrgyIljdXzOMiByuMEG6f/1fK8PaqXGYD
 9NcHeMRdhCc+hvXkBUlK/8tGZFWksQtxuI+QZLwBGtfs7Kgvjtj653R0S7lhV4UedZlkOdjC
 4X3LjnYL3Gh3nxVv0Tvr8B0HHWyTvdZRQ/73cGzqP4oEbBaus5SUEgC6JmGlFTLDxlGpjW65
 BjiYY3SxMxckbVcpZPmSPh/Nl/lOOHNW/St2yHtldZ3NPfkE9rE7iERoXnZZzVmB6MbAYlLp
 O7coezM/R33uZgtWDrkgLiHLa5C4PuyUMdxMs7aKHp7nzOIaPTz4iksqnyJFphUrOxzvsWXZ
 RO0SM+VR+4nX91wwH50aS8HHShEWu6zJu3lqDimpvuBNgkF3EaVZJm7/HvudidAejVOJ5T6D
 RTutu2z4sxD6r5BHwIAG+osFqoQzIUPgkf6X4aZWfik4miUbpeqob7+jV8n9C2RTGKZC8u87
 Z+tqt0SsvitkPmg8T2bm9UaUt4r4LJVmvQrcwQW6baaThikWXUeI7113YouU/lpf++b6H08T
 CrQd2ZkAjeVsfGot/njyIyLYzpzzdDi9js0yvLFMq9Uh+qL6Fu8PYZc
IronPort-HdrOrdr: A9a23:SUNTxKEWIjI1mJqlpLqE6ceALOsnbusQ8zAXPiFKOHtom6mj/P
 xG885rsCMc5AxwZJhYo7y90cq7IE80l6Qb3WBLB9qftWDd0QPDEGgF1/qB/9SKIVybygcy79
 YCT4F/Fde7ZGIVsfrH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="51551819"
X-MGA-submission: =?us-ascii?q?MDFL2FHh2KpVQ5yT1wvbe4xxDLsU0hOUI8Xq0s?=
 =?us-ascii?q?az0sz3+mX8A2aCNZBCvTVtcQvl+YSATnmtXFcDbZ1nyEcNBaQJCRbso9?=
 =?us-ascii?q?B5GCS931eeIU7jmTBoVk+zsmrPA6N0fKbR4ysNFSyB7E7NzcDCwgZ4m3?=
 =?us-ascii?q?c5qAisymSr6/3iAEyOSkFDdA=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.220.29])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 09:25:47 +0200
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 721AF1FE00;
	Wed, 29 Mar 2023 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1680074746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShwHsB/KkELwzyEZDwa4XqP7hPtXAant2Ydr/uTw7CA=;
	b=YWSGZo4L8d9hfQqbPv84f780i+phz4kSgUnkTiwJthtFaSJOCi0tKl9ro/NHEz0+15LQgQ
	6OsC6kGgm9N/ZmWqbEBY+Rj71nXkN8Syul4DM9TrZ7W6GKTjVzC2ERv9DprOY/JCBbgLju
	YczEXF9UUdQu2lsPROcBUQykrNgMIsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1680074746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShwHsB/KkELwzyEZDwa4XqP7hPtXAant2Ydr/uTw7CA=;
	b=tumkoantk15bKBa+IjxzbnshcQYtmizWvZ/3amdRGICZosf1qR4Je0p8AVt7Ig4MH3cJO8
	rab7QDWYDJcXE4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F110138FF;
	Wed, 29 Mar 2023 07:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lP2NFvrnI2SpPgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Wed, 29 Mar 2023 07:25:46 +0000
Message-ID: <4db2129a-835c-9943-c8c2-54d1d6eca898@suse.cz>
Date: Wed, 29 Mar 2023 09:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <4a7d08d1-7328-047c-52f3-dc62755cdbaf@suse.cz>
 <e4ba5b28-77b6-8013-ed76-e22e090496cb@web.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e4ba5b28-77b6-8013-ed76-e22e090496cb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Reconsidering kfree() calls for null pointers (with
 SmPL)
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 981
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/4db2129a-835c-9943-c8c2-54d1d6eca898%40suse.cz>

On 3/29/23 08:18, Markus Elfring wrote:
>> It is valid to pass a NULL pointer to kfree(), it checks for that.
>>
>>> I imagine that such code should be reconsidered once more and improved accordingly.
>>
>> The only potential downside in the scenario is checking storage == NULL twice.
> 
> Will programming concerns evolve any further?

It's very unlikely that the behavior of kfree(NULL) will change.

>> But this is an error handling path, not a fast path.
> 
> I hope that also exception handling code can become efficient in more use cases.

Nobody will notice the efficiency, and it's not the only goal, code
readability is also important.

>> On the other hand, the code may look like this:
>>
>> storage = call(...);
>> if (!storage)
>>     goto target;
>>
>> if (some_other_condition)
>>     goto target;
>>
>> target:
>> kfree(storage)
>>
>>
>> For some_other_condition, we want the kfree().
> 
> Allocated resources should be properly released.

Sure. They are properly released in the above example.

>> If you changed the code, to remove the extra NULL pointer check, you would have:
>>
>> storage = call(...);
>> if (!storage)
>>     goto target1;
>>
>> if (some_other_condition)
>>     goto target2;
>>
>> target2:
>> kfree(storage)
> 
> A label like “free_this_resource” can be nicer, can't it?

Sure, name was not the point. Just that there are now 2 labels.

>> target1:
>>
>> The extra goto label and larger code is not worth saving the NULL pointer check,
>> because this is error handling path.
> 
> Some code reviewers and programmers represent other development views.

That's the universal truth :)

> 
>>> How do you think about to achieve any adjustments in this design direction?
>>
>> Only in cases where it would not make the code more complex, i.e. if there
>> are no "some_other_condition" that jumps to the same target after allocation
>> to storage is successful.
> 
> Do you find any implementation details worth for another look also according to
> a special information source?
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandreleasingresources-CompliantSolution%28POSIX,GotoChain%29
> 
> 
> Will circumstances evolve in ways so that you would adjust a desire to stick
> to only a single jump label?

Depends on specific code cleanup. But generally, not if the change is only
to add an extra label to skip over kfree() - I will unlikely consider such
patches as useful.

> Regards,
> Markus

