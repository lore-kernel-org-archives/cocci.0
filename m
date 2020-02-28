Return-Path: <SRS0=NuX8=4Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FA5C3F2CD
	for <cocci@archiver.kernel.org>; Fri, 28 Feb 2020 15:14:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C894724699
	for <cocci@archiver.kernel.org>; Fri, 28 Feb 2020 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yaerobi-com.20150623.gappssmtp.com header.i=@yaerobi-com.20150623.gappssmtp.com header.b="G5Z9Gkxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C894724699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yaerobi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01SFEAX6023037;
	Fri, 28 Feb 2020 16:14:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 62C5E780A;
	Fri, 28 Feb 2020 16:14:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5E1E77800
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 16:14:09 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:844])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01SFE6Al015374
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 16:14:07 +0100 (CET)
Received: by mail-qt1-x844.google.com with SMTP id p34so2236163qtb.6
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 07:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yaerobi-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:organization:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=uuEQvBeVhLUUHAQnUfU4s49jcfk0XmUl3t6jcuQQgiM=;
 b=G5Z9Gkxl88NPpjkYovkv+4Jv9+K5xwlF9pum3fBv7Fc6Qc5AHyHUt+PyZ+40y/FLOE
 kKIGD2HIvEPYGJ82qXD6W1O227wx/qhGtedqI1uRe/fsoRHwt+QqnSyvlKz2Rd199xEt
 1CfHprlc6jLaKtMU6jPNi767xdkf4ygAzhdPNlU14XOPE1yznlE664KfdPTuMFoqESOx
 HkkUaADds27fh+Sc91mbQjY0vZl+0pB09MwbCBgIMBApr+A1mgTcc+0IwBXvTDpbjkBa
 YWo1ISIYdO8CovLKDjdMC+crKSOMJRGNn03j0cO5XrgMLgXaOz9uRZNvyHRtshZ7NNLM
 exvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to;
 bh=uuEQvBeVhLUUHAQnUfU4s49jcfk0XmUl3t6jcuQQgiM=;
 b=sm3AH7dVVIAKtULbXZlezkjN2cXGju066LKYO3lvXj/3UMATL6c/O3YnE+EFEKcIKA
 U+14592yZC50hUsbrAJkzdBdsaebRw3jI/0NbSfb9ARknKQCtpO3W1DZRjlL5yo8rdRY
 28CIywkfmwINXHy8DS3dsofBC6vxoOFBahhlACzHB6Sw7Vsv7YdB+KVXcbUqwRecmLnF
 lhsAgi7C73FTampdTxw+8zPvmO9wjf9hwNj3Bng641eyJkbdDhh3rYjX/VKZxxrB48Zf
 gHQs04zZW6axUW76CweUprX7Uz6E2sAcSwzwyECMthYrwPoUS1CsKFXCCKNq2TXs8g2d
 mVyQ==
X-Gm-Message-State: APjAAAU9wG0eyWnKxmjTw8pmo/ZlUa8N4Yo/6wd3+bOVjhMVn9vce1yg
 bZc9SzgiYNyQNICcaDLO4iHg4eWmGqI=
X-Google-Smtp-Source: APXvYqz1WqTddLrI0dZIu3nr2bsgVmDNSgqHLZWKUUO/XfgnVwQLNLU4HZO+qg6CfqLKnuhLPSw1yA==
X-Received: by 2002:aed:3e6d:: with SMTP id m42mr4580588qtf.187.1582902846058; 
 Fri, 28 Feb 2020 07:14:06 -0800 (PST)
Received: from [192.168.0.102] ([181.91.244.81])
 by smtp.gmail.com with ESMTPSA id o3sm5157235qkk.87.2020.02.28.07.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 07:14:05 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
 <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
 <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2002271044550.4309@hadrien>
 <1183e7d0-b6e4-834d-5b27-47c43661bae6@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2002271102350.2973@hadrien>
 <CAFNO5of+YgGHTkdidk-fu8U95zEtmPhPPZdNW30Q12Df1j2cbw@mail.gmail.com>
 <alpine.DEB.2.21.2002281344590.4267@hadrien>
From: eamanu <eamanu@yaerobi.com>
Autocrypt: addr=eamanu@yaerobi.com; keydata=
 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
Organization: Yaerobi
Message-ID: <de4ad240-1af0-0f14-b48e-4d1c9f831070@yaerobi.com>
Date: Fri, 28 Feb 2020 12:14:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002281344590.4267@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Feb 2020 16:14:11 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 28 Feb 2020 16:14:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle depends on unmaintained pygtk
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0021897502=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0021897502==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RHAfWS9qmnNovI3XU0HxzdGH84nImwVhB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RHAfWS9qmnNovI3XU0HxzdGH84nImwVhB
Content-Type: multipart/mixed; boundary="EHdSPeWrPj0wRk20GrnatXatxeLg9x4aM"

--EHdSPeWrPj0wRk20GrnatXatxeLg9x4aM
Content-Type: multipart/mixed;
 boundary="------------B37429E65D64ECB652AABB2E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B37429E65D64ECB652AABB2E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/02/2020 09:45, Julia Lawall wrote:
>
> On Fri, 28 Feb 2020, Emmanuel Arias wrote:
>
>> Hi Nicolas,
>>
>> It seems that PyGTKCompat is not in Debian, so IMHO I would not consid=
er
>> that option.
>>
>> The files with pygtk are:
>>
>> docs/manual/cocci-python.txt:The latter depends on pygtk2, and the
>> dependency will not be evaluated until runtime.
>> python/coccilib/coccigui/coccigui.py:import pygtk
>> python/coccilib/coccigui/coccigui.py:pygtk.require("2.0")
>> python/coccilib/coccigui/pycoccimodel.py:import pygtk
>>
>> So according with Julia, removing that files will not affect to coccin=
elle.
> The files are gone in github.  We expect to make a new release within
> about a week.
>
> julia

oh great! thanks!

Emmanuel
>
>>
>>
>> On Thu, Feb 27, 2020 at 7:04 AM Julia Lawall <julia.lawall@inria.fr> w=
rote:
>>
>>
>>       On Thu, 27 Feb 2020, Nicolas Palix wrote:
>>
>>       > Le 27/02/2020 =C3=A0 10:45, Julia Lawall a =C3=A9crit=C2=A0:
>>       > >
>>       > >
>>       > > On Thu, 27 Feb 2020, Nicolas Palix wrote:
>>       > >
>>       > > > Hi Emmanuel,
>>       > > >
>>       > > > Instead of porting to GObject directly,
>>       > > > can we use PyGTKCompat ?
>>       > > >
>>       > > > https://wiki.gnome.org/Projects/PyGObject/PyGTKCompat
>>       > >
>>       > > The problem is resolved by removing the python file that
>>       relied on the
>>       > > unavailable library.=C2=A0 I don't think that that python fi=
le is
>>       useful.
>>       >
>>       > It looks like python/coccilib/coccigui contains the offending
>>       files:
>>       > coccigui.py, pygui.glade and pygui.gradep.
>>       > But according to vimcom.py and vimembed.py, these laters also
>>       depend of GTK.
>>       >
>>       > Should the coccigui folder be entirely removed ?
>>
>>       Yes, they have already been removed on github.
>>
>>       julia
>>
>>
>>       >
>>       > >
>>       > > julia
>>       > >
>>       > > >
>>       > > > Regards,
>>       > > >
>>       > > > Le 04/02/2020 =C3=A0 16:25, eamanu a =C3=A9crit=C2=A0:
>>       > > > > Hi!
>>       > > > >
>>       > > > > On 04/02/2020 11:59, Julia Lawall wrote:
>>       > > > > > On Tue, 4 Feb 2020, eamanu wrote:
>>       > > > > >
>>       > > > > > > Hi everybody,
>>       > > > > > >
>>       > > > > > > Sorry if this issues is duplicated, I am new in the
>>       mailing list
>>       > > > > > > and in a very quickly searching I didn't found about=

>>       this issue.
>>       > > > > > >
>>       > > > > > > I am working on Coccinelle package on Debian
>>       > > > > > Thanks!
>>       > > > > >
>>       > > > > > > and currently
>>       > > > > > > exist the next bug [1].
>>       > > > > > >
>>       > > > > > > There is any plan to port to use GObject
>>       Instrospection?
>>       > > > > > >
>>       > > > > > > [1]
>>       https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D885267
>>       > > > > > I think we should just drop the code that depends on
>>       it.=C2=A0 It was added
>>       > > > > > for
>>       > > > > > a MS thesis more than 10 years ago, and I don't think
>>       anyone has used
>>       > > > > > it
>>       > > > > > since.
>>       > > > > >
>>       > > > > > I will look into it.
>>       > > > >
>>       > > > > Great, if you need help, I can help :-)
>>       > > > >
>>       > > > > I will wait for any news. Thanks
>>       > > > >
>>       > > > > eamanu
>>       > > > > >
>>       > > > > > julia
>>       > > > >
>>       > > > > _______________________________________________
>>       > > > > Cocci mailing list
>>       > > > > Cocci@systeme.lip6.fr
>>       > > > > https://systeme.lip6.fr/mailman/listinfo/cocci
>>       > > > >
>>       > > >
>>       > > >
>>       > > > --
>>       > > > Nicolas Palix
>>       > > > http://lig-membres.imag.fr/palix/
>>       > > >
>>       > >
>>       >
>>       >
>>       > --
>>       > Nicolas Palix
>>       > http://lig-membres.imag.fr/palix/
>>       >
>>
>>
> >

--=20
Emmanuel Arias
@eamanu
yaerobi.com


--------------B37429E65D64ECB652AABB2E
Content-Type: application/pgp-keys;
 name="0xFA9DEC5DE11C63F1.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xFA9DEC5DE11C63F1.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBFw1x6oBEADBrJOCQvmkffxnUyGkx74a8xifdgEZLu+Xz6hV7CEyl1/71+8x
qIZr9s09w++yPod938Se/gopqgaXpIx46lKp1EI0F0hFoYne5ub6EsIxcyMCCFwb
TeR8CQt2EJ86hpS+FYvbSTbwvNPCNT/EZuyE3KXrZk7j8nhoAobQwTZVE6agRULU
TrxtH1q6w6OhBMtAyZpxRmq9nhLEYRvtSm++pyRK+N40pgUED+psPB12NhpHfMpH
fSoUyWKMC/7S34XMp1JQtogO4MFjviUpI8iWjWdqJvs/VWQe0gQqnH/P4DMKyWdb
gJbv9S/kj6r00SsGpMRq15wOcLdEPDST8vb7MDOAG77zBJy3kY3U7JbrWgadwniv
D/nNHTeJAC6hFY/rfmKvWUKPyKO+Y+H6g6sWHTEjm/duIrvm2essMb08ebGoIcjD
Qf6q1nX86fDY8EM9L0IueN6CqybD2AyVQbifqA8Z8968Vrhl9TQOemNkHdqhhTHC
9/H8osGj4pZF7Rqq3OKGoG61kbmti3142mGtfupCVRyRoLeR6BZF1s1TrXxqCXWt
ueyw0lCidfCcfYQAYsMsFUQ951BijSj60I/KeUmdyjgjfgFthzaG47wr9jQ1QuBo
msH+/7kh9CD5sYaA7lsVqhIYZl9gYvW9eTWpPx/+fc0/TyZVAdj7++gOtQARAQAB
tD5FbW1hbnVlbCBBcmlhcyAoZWFtYW51QGVhbWFudS5jb20pIDxlbW1hbnVlbGFy
aWFzMzBAZ21haWwuY29tPokCVAQTAQoAPhYhBBN5Z1W7xyu4q+Kutfqd7F3hHGPx
BQJcNceqAhsDBQkSzAMABQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEPqd7F3h
HGPxZb0P/3yInNRXQmgia8PwQMdlnndgC6pHelNUYLujx3kW+zcYCR+9gOv5zpP5
e0kEy7mBW/Kpc3Hbkt8Tobqch1AU/LpcLmsD9eZj/WMZObv2AyXPl4Tw5+KPT9Ey
yCHYGA+amvVciCrBlrKiM2e9RfyxKuC4EMxNQ0q+82sM3cMEU3XerkO6yjks7pVg
UZxBpCChf7S9WqaQ2dfMqrClEgXSAPbT++j0M9gZfiu1kIkuinRWzCxUKyeoyTfa
VOsjywyFJBx75NfT9Q40XTz1vCBxh1WMjIH0AyLUik0GWEoACOnS9oB86hAo+H5F
KNmw91CwCcXzxzs1iPKMZl7+qPBFCUt8ysdL3bJ8CZVU3GUk2kI6MctkzjHBqLX3
lanvMebKM4nlXvftQr+3d7z5n2A+oW636B7eaoNSDDktAhyYx1/uzOtH4lKG1iEb
T7yHUSW8pCX47eh61FWsjEtg8ek5NYCYGFYyxeCqpp6ZJubNTEmnWCvOFiIbGTys
f17TPiw4uhY79PFaRjFTZJDsHl5Iufihlab9D6myWnjDweytdggIbsmXDdQycf03
zQBCV5d6B9Atd6iSPQXN98Xldx2q25bmLdYmlMQwDRMFm90UYHtBp9ky3ft68ehN
bKHZtybrZEjPt32KNsmRhVO/U6EWpcU7jZTHzNTf4jIoVdHCbDTJiQIzBBABCAAd
FiEEEt36hKwjsrvwSzE8q2RfQGKGp9AFAl45gGoACgkQq2RfQGKGp9DBGBAAqAVh
DU3dmQMVvJypfo9NVF7tFDC9m/3LDR/FXQFNnY7eFeonSMxgc1EFI76y6wNfT6tn
fJTmcpftLvftO6psfwJIQZ9axebf74eGQ1O56fU8nvk0de7p6MSNBbUbA+NM4UJ0
CAoVPCu2hWDQVhFCosz2DdNezoW+bSQuw7C/hGhFrzCz1SWS2MZZHLzyK7v//oMN
qR5I+k8JsoW77xthhNlCcqIV3GvcrqNaQtoEd8RRC9nWeDkl4MeesNQyClsjNryj
7KKfF6a/CvsoYCtviAE2udpfNvaf9aF3UowKDM8NhaIcaXtxIhYBVjCysbk2z/T1
DKJ4DZzVNJw68GUi5kwRYuJuvs97kqnPRUkmkujU+8XNmlXTjmUQQPrBrIo2N8cY
0gjaTT65D0zebXZ3GCsfIV/JIRIBG9jiXn9xk4VPz6DKkXoJDfMw7qXiVd7qb5KG
7gJrB+e986h7crjQ5xO7YHjx9VoxIJYCqDTy2lWtAMhYWLAryYHt51JtN9sqa0Er
5IDrOHFcrSWffyRZswOmw+rTnu94xx98Otw3lHn9lVpnuEXvbBRBVy3dj7nq+/2u
VncKilijBZNBhm7+WvIkyxgiYz2DAjdRW7z8KNty4ZGgZfxZbQ1cQZ9Tvq94+k+M
hlEEecJkFPvJVrP/SJCrlxOmM6llTqjD2J9M+pW0U0VtbWFudWVsIEFyaWFzIChl
bW1hbnVlbGFyaWFzMzBAZ21haWwuY29tIC0gZWFtYW51QGVhbWFudS5jb20pIDxl
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
=3DChhA
-----END PGP PUBLIC KEY BLOCK-----

--------------B37429E65D64ECB652AABB2E--

--EHdSPeWrPj0wRk20GrnatXatxeLg9x4aM--

--RHAfWS9qmnNovI3XU0HxzdGH84nImwVhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEE3lnVbvHK7ir4q61+p3sXeEcY/EFAl5ZLjgACgkQ+p3sXeEc
Y/EZmA/+JpGVzwR2rFnqYIw+OseiPj/M8Wi6X575MmgjRWs1IxQonAfh0rpWL/Pl
HjN7qOqLAJByswqTu4fzbeuhAVkXyzIIi9Ku9nlMQBc2bcbbSZl74l2iE+VFYYET
Xxw7oImtzsRausi+12dAArq28fIbaH+V0rBHGscwnHe9CfEH36kFN5svdXEW8buN
5Ie9zohN0kiaTMc/wcb3ypvjmc1TQOotVOHdf1ixMGRnB6Mu53N+jvywSiUkWYv3
PrPbv5C3mrqi9tfoe5JOmYIS47dI8tSG0PVarg/wmHb970GoHz8Nkt1pXEM+mveo
P2Ckyvw39aaeFlOUV+L8jumCWSbJrIEAeVQIqfBu8aGCv4FIs12tcDYBIEeHhe+s
rnhu09MyfVupVtDaJMYqwJC/vuz/gkRLlimc9VkLfbsluNZtWet7PeZw8z5BAo4L
ghOnc7DJOAh1BYSZ4ABOs1TUW5t1I9eSRaXWCYowLsfAmiGD0/sHjpGIRezxBbHW
z5wTdY2nI5x216QXiKmC61ElMJjNXbwOmdn+4n/w2OJh67Yhtw1a3jBfVPi/6E0T
5m/hiHxwSuRS5YkOoXy4SN+vEhvCjfrUXUAOYYMp5JLlmAb9lO4WHgHV3P9KpoQz
Hl/XjISHHOJn3ercQrXR7Sc4CbiIHmmgUC1/c+3vY3eAr9h5Vf0=
=RnoT
-----END PGP SIGNATURE-----

--RHAfWS9qmnNovI3XU0HxzdGH84nImwVhB--

--===============0021897502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0021897502==--
