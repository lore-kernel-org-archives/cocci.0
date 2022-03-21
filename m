Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D449C433F5
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G4flOhRJRtDS5F0vlSz6QlGQH/7kgEqr11MjW72y7as=;
  b=bSZmTqoU52gUbfsCXS/pzKFqcOMebRvRU9nnp8NY+RmZGvzQgyi/Yso6
   zfac6y21IbNOclbzuJ+yEXMk7iUC/QniShRsFtGN+Eia4UDFgDtcQNh4y
   CE+cqWl8wv8JCwHGLXi51Qinkt/pY7x9gjo7FPWfLTxyuOyf1d6bviIRf
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27307651"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 19:39:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7CB75E0219; Mon, 21 Mar 2022 19:39:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77CC9E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 19:39:43 +0100 (CET)
IronPort-SDR: CeLri7KEdeJXFr68yiFgykgBK3RG8/i/QfUlECjDVwmxJXTXoA89SRVoGJNh2H+IlkmZAvDb9y
 mcYWVGz7Zl/odBGu2m7TtQ/dq1n6XGc8YPDlvgcb8NAgWYexQqJpyew3qghG32zBEgSmN4vTa8
 plbmUHOvFEwrEPmZn7piym77qaybaz8tDYkiFP0ABrR/TM4xmh+iTSiBgC7/gMwkODPq9wrsdJ
 vi57uNmeLGS+6/YSKHDTzGb0znjbHiCc+fJHemWw2Br3Kao1E5+UdFk1iKMLl/mns2A6djpKGY
 7sy2HGJHjzROKyw8wnlQ6Y0u
X-IPAS-Result: =?us-ascii?q?A0DKAQBpxThihwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiZ+VysEC0SEVI5zgiiEH44djCMLAQMBDTkFAQIEAQE9hEoChDwCHQcBB?=
 =?us-ascii?q?DUFDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHD?=
 =?us-ascii?q?hAFNgZeBmQEgUsEgXQLNA2CNSKDbAECAgEjHQEBESYBBAsLDgwCJgICVwYNC?=
 =?us-ascii?q?AEBgwABgmQBAw0lC61UgTGBAYIIAQEGgT8BE0GCNB8sIlKBWwMGgRAsAY5IJ?=
 =?us-ascii?q?xCBVUSBPAyCRzA+gmMBAQKBXoMagmWYdi0slH6tcTQHghKBOoFBDIlClE8GF?=
 =?us-ascii?q?C6WPQ4GkW2WW40VmW2BeYF9MxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDW?=
 =?us-ascii?q?TOBC4khQDQCCS0CBgsBAQMJhUcBAYwpAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:L9QCeqygaAZyi7Gqkx56t+cqwCrEfRIJ4+MujC+fZmUNrF6WrkUGn
 2tKCzuEO/+PYmrweYx3YNm3pkkC6JaDz4JmTlA/qlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 4qq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhsi
 8tn7J2PYj4tHbPFhN8caTJHSyJxaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlUBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/+VvocHgmtr7ixINbGCS
 sEeUTNuVkz7bCcUGkseC70Mtd790xETdBUB9Q7L/PNpi4TJ9yR617PmMfLOa9mSTINUmFyZr
 yTI5QzE7goyMduC1Xya/3jqiuKncT7HtJw6Cf6m3Kdrv3aqwk8NAQEtVGGQvqG6hRvrMz5AE
 HA89i0rpKk00UWkSNjhQhG1yEJoWDZDAbK89MVlsmmwJrroDxWxWzBYFWQdADAynJBmHGxwv
 rOct46xXVRSXKuppWW12pr8QdmaHC8TMWYIbDIeJefuy4S9/Nhr5v4jZuxjHa+zitTzFXTIz
 TmOvkADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdtlW/soGNt10RiGuZi2qAtwKzARFoct/xc7V5l
 CJY8/VyFtwmA5CXjzCqS+4QBryv7PvtGGSC3QE/R8h6qmXxpiDLkWVsDNdWexcB3iEsJm6BX
 aMvkVgPjHOuFCb2PPEsOepd9exwkPG6TrwJqcw4nvIXP8QvLVbZlM2fTRfehijsllQhi6cyJ
 d+Sfq6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50n5jdK2OSDEIZ9YYQPmRr1ot8us/VSFm
 /4Bb5bi40sECoXWPHKImbP/2HhRcBATH47tkcVLe4are0w+cI3XI6SLkOtJlk0Mt/g9q9okC
 VnmAx4GkgWj3SObQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 adXZMiKRPhCE2yV9zMYZJj7jYpjaBXy2VPQZXX4OmBncs4yXRHN9//lYhDrqnsEAB23gs1i8
 beu4QXWHMgYTAN4AceKM/+ilgvjvXUUlO9ocVHPJ91fJBfl/IRwdX7ug/VxL8xVcUfPwT6T1
 gC3BxYEpLCR8tFvr4ST3fiJ9t77HfF/E0xWG3jgwYy3bSSKrHC+xYJgUfqTeW6PXm3D+JKkO
 bdfwcb6PaBVh11NqYd9T+1mwK9itdvio7hWklZtEHnRNg35D7R9Pj+Z0MMJuqAUnu1Vvg6/W
 0Su/NhGOOzVaZ2/TwNLfFIoPraZyPUZujjO9vBrck/00y9A+ubVW0tlORTR2jdWK6F4Md9+z
 Op96tQa7Rez1kgjPtqc13kG8mORMjofXq9hupxDWN3njQ8iy1djZ53AC3aqsc/VNIgWahEnc
 m2Oma7Pp7VA3U6cIXA9Inj627YPj5o5vh0XnkQJIE6Em4aei/I6tPGLHe/bkuiIItR7P+NP1
 qxDMkpoOeOR8j0uiMUrs6VA3e1eLEXxx6Az4wJheK7lo42ASWHHamEwUQpI1F5M6HpSJ1C34
 5nBoFsIkl/WkAXZwSY4H0JowxAmoRqd6SWa8P2a8w+581XWrNYrbmJCpYbFlvc/Pf4MuQ==
IronPort-HdrOrdr: A9a23:SXBOWajT9XG+0kmE/Pohr3dVmXBQXv4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27307643"
X-MGA-submission: =?us-ascii?q?MDE8om3wicEjzsyNpZR5qJFMuRCA0jta4pNIzf?=
 =?us-ascii?q?yxZVmMUm2uYcQdhBZAP76FiEwSIp/hnLyRmYwi/Jy2cg/Kgtd2pLx7dG?=
 =?us-ascii?q?xjEB2JeikUEdX/VWejFgdA+DlVWzMwMoGXAFBdybsSOMTPpZAQMQhPrK?=
 =?us-ascii?q?HwLDuShQ5t4icpqFqzX0A7KQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:39:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647887982;
	bh=G4flOhRJRtDS5F0vlSz6QlGQH/7kgEqr11MjW72y7as=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=SxbclAMUom79EGrxYwqAVMWRJHSvgZTcDnSn3Hoa8TUJCCMHR5O/QwQjMUeu00qDg
	 TRwJekiS9UFg/+kmSck0nRlJ14tAmnPP0/axuga8qwZl8Gz8E8uIUO7iyjvF2SgoNj
	 HQ3xanqCrgM40/RG5bvgycwdbZxbnOC46mz/EiNI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.154.81]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcll-1nbZiX1f7b-00VkwS; Mon, 21
 Mar 2022 19:39:42 +0100
Message-ID: <aa0bc462-3e58-e5f5-4039-06e66a790746@web.de>
Date: Mon, 21 Mar 2022 19:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ac59aaae-6e1d-a5e6-e568-2049dc961f93@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HoPWK+pfK0HNWjL0b2VRWlombGQyH6Us4CJBU4KJ0OBa5WBTljH
 tmG14ofEqeoBxHp7rHrbGuCu7exi0ucUNj67pAegLwkZDz7JKIXd0eG/tmpgtztY6DYw1g+
 iMT4PIRoq31sRwBbgpNhK8x2+A/pQywH26UHQK8SCv+gJZPeG2TGipurlhcwC3fW9+lKZnh
 4W+jzH4dr66LlNlM3KMxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aFucFBT7PMw=:CFj6H6coD+pLuGB16/t5HI
 N0OaZadcNIcHo1/m5NroXdl90aeGfgFSpYzLRr92U889wYE9fauK1HT4QwzdBX2RMcOLzTmP0
 Gg4ZT7h85vdKZfHBhbiCHo+GILEZZ9VTeFCEJAAtwxrb963y1KfmdxkuAJmcxIbQ8qK4vnrEl
 znEHfwkQUszb6x7Ictym4mix0nwUA0aGQhpszCGF390dzl6dJXVWD17eGOFLDmHxziwVXdfBN
 ZivGCsXUOaePe2TD3s0LyQqtfhFBs+XbQxkjH6ulm6e0rN6RiHcM0uWAPMzaSmgosHzfYkwNK
 BkmxvO9K3tze3j6wibLFsWH+45hPNZBdDDwOhwVA8REHC5VQTr9w2cBF39nXWqHXK0kj13DJ+
 eRJYnjvyJQQXY1aRSOxusNTI11Ve6w8PQFTgeR9vZ6k2qnA7U/yH40ntH3K5JZ7lAJ1xB9MPI
 7B5zv2ueS0VcVcn7KzslzWzLwF+amR7Hs3Uon5vx73crCHNQFEgSK5D2w0jXDHLSVmFzI4Y8I
 WpL6N47lCZEElOgaDR7N6/L6DnEiMbWJaNxBa3lHmUrJxaitS+iX3pGDwoZZDwf8sXheZo1rH
 qNPHaIxy5Y+nnlB35is9WBGVmX6vPccY0I6wUdHy77pka1o7HmbtoYzTtpuLg00EMXZTI79MH
 rXp0uQGNoDquRHCdLDk5wMpJnFtidyku5XeH75Cri7Cuy62sTJvRvwPAb+9Qt58irlNossc36
 6OTI+jgqoKQ3tVXx4joOkL4OjnuOB4tD/ae65vklf1MctJKnf3MHs4Xwrav8L7RStrOEmy/Ix
 O08BngJ3JHQs+jRh+EqK6qwXCo+bYnIvi/WwBuZYxGUqMPYNC05ng0l7UUMVc0nhibyUXaPNG
 5Seciyea+WqkZTKFOZYlrbZ2Tp5ab5ZUgOhQC2WctQUMq8/DzHXXiq9CY9YFLF34plLm2DJEr
 W+TQjzrQeChS2o0hDdHfj35sTDMDhM3KvHGccWhCKN7vFgAM2eAjdYEg+J5dEe277g92OYJSO
 eXfAYOj5EqV7EG0zLXyFQdGPdYs3neNdoKorY4r/KJTBeq00C/Dxug7V5pLKq6p1/Aao2QmZ+
 MVeHPxhLdfg88o=
Subject: Re: [cocci] How does Coccinelle call a script language from OCaml?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 278
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/aa0bc462-3e58-e5f5-4039-06e66a790746%40web.de>

> I'm curious how easy it would be to add Perl, since that is my most
> comfortable scripting language.


There are only a few hints available.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/manual/cocci_syntax.tex#L686
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L686



> What source file(s) handle the script invocation?


Would you get further development ideas from another file?

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/248a2742e76ceab620d67=
967a537fc5cb9282405/configure.ac#L278
https://github.com/coccinelle/coccinelle/blob/7cc8d6453a2f92ac13f458bcb496=
a17c79dafeaa/configure.ac#L278

Regards,
Markus

