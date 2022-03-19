Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39788C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L6giUi7RHtiDUjBBYPkBfAy5gTS3kJdUw12twadf0EM=;
  b=dVwOFD59oSaZZg4SEOQudh4AqHrUjaOdhQ+ltXXciFjveqiDXV1OvLec
   LO47FGZMMWlY3iKxaqWwxkPVbD+liDyGEmJVXKKO2Ru+EZ6VqfSXOLgT4
   TBW8cQ4QEAt7B3HSt5TLPvr2imxvIoc+zC3SjLrFmciYMzOd4R+VZ/ELY
   4=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27016255"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:22:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E861E0219; Sat, 19 Mar 2022 18:22:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 66A2DE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:22:22 +0100 (CET)
IronPort-SDR: Bb8ijEj3/dVcFCGiosJ5a2xV9rIz51QXJh0q/Kn+crS4wkkjCD4O6ybhMUPslqstfgjGJ7WElr
 Lqqt4UGBSaz86onhp3z8Y3AWCCp4qhkTb79ynG1SUbSzGblgH8fg7bfVD7RBu4/J9OrCw1Gzve
 B4DMa4QJwicUggWX/3O71FSQOzVxuBUoDHYHDlTIRzDuBZ/JB88jx37bTabz3GpTaQQfYRxx4n
 Lc9q9WGvJIqSWbyhnP+kB5KUAKMw0MFFVNYQ1QYNa4uUTC2HKTPQcuTWvYHuphfpTtOWs3gCmH
 5sYMPZqMD0WCGjBfdT7f4tz4
X-IPAS-Result: =?us-ascii?q?A0DCAQD4DzZihwMP49RaHgEBCxIMQIQCgVUrBAtEhFSOc?=
 =?us-ascii?q?4F3MYskhxiMIwsBAwENPgECBAEBhQcChDQCHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0D?=
 =?us-ascii?q?YI1KQGDZAECAgEjHQEBESYBBAsLDgwCJgICVwYNCAEBgwCCZQEDDSWuAYExg?=
 =?us-ascii?q?QGCCAEBBoRIHywiUoFbCYEQLI1PeicQgVVEgTyCUzA+hEWDGoJllyCCJ4EGg?=
 =?us-ascii?q?R+uF5I5NAeCEoE6gUEMnhEGFC6WPQ4GkW2WW6cCgXiBfjMaJIM4TgECAQINA?=
 =?us-ascii?q?QICAwECAQIJAQECjh0ZhAyKLEA0OAIGAQoBAQMJhUcBAYoFAQE?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV9/
IronPort-Data: A9a23:lSpNRqqrHyMZwpkx42vbOYdKqjJeBmIJYxIvgKrLsJaIsI4StFCzt
 garIBmHOPncM2Wmf9AlPIm0oRlUvsfWnNExSwo/+309HnhB8+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYQ79gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSUdDo0GrPykt0fXghZHi1EL6hMpKXudC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KZecmpSKEnewbneLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwjW9r2pgVRp4yY
 eIYRWRhXRPRUyRJI1cxE50MmOCagTrgJmgwRFW9/PdrvTGKkmSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 2gpxzcKs5Y4zU6mX9jwUyeqpXTYpDdJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gLRw4izWVSDpJXKGSvNrN94uBvvYXB9EIMUWcMTZScoizUJiKQ0iA7GRN9+CsZZZfWoR22pm
 1hmQAAEh7gSi8oC0an+xV7OhyDEm3QkZgsy+xmRQW+vqA90DGJEW2BKwQiGhRqjBN/HJrVkg
 JTis5bHhAzpJc/U/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43bplZJ2e0P
 hGD5l85CHpv0J2CPfcfj2WZVJVC8EQcPY+6PhwpRocSM8YqLmdrAgk0OBXKhQgBb3TAYYlmZ
 MvFKJ/yZZrrIf0plXK3QfsQy7km2mg3ygvuqWPTn3yaPU6lTCfNE98taQPQBshgtf/siFiLr
 753apXboz0CAbWWSnSGquY7cAFaRVBlXsqeg5IMKYa+zv9OQzxJ5wn5mu96JOSIXs19yo/1w
 51KchQBmQSl2iGfd1nih7IKQOqHYKuTZEkTZUQEVWtEEVB6CWp2xKtAJZYxY5c98+lvkax9Q
 /UfJZefD/4JRjmeo2YRapz0rYpDchW3hFvSbnT/P2VlJ8ZtF17T59vpXgrz7y1QXCC5gssJp
 eHy3A3sR5deFR9pC9zbaa70wl7o5Sodlet+UlHmON5WfEmwooFmJzav3OA6KYcAJEyblDed0
 g+XBzYepPXM+tNkroOW2Prc94rwSrlwBEtXGWXf/I2aDyiC8zrx25JEXcaJYSvZCjH+9pKiU
 uMJnfvyB/sKwQRRuI1mHrc3lq8z6oe9p7JeyQg4TnzHY07yU+FlJWSam9ZCvOtBy+YB6wexX
 0uO/PhcOKmIYZ+0TgROeVB9NunTh+sJnjTy7OguJBuo7iFA/I2BDRdYMS6KhXEPN7ByKo4kn
 bwstZJE8QC5kRZ2YN+KgjoNrjaJKWEcFboqvNcWDdaz2AYsz1hDZ73aCzP3uc3eNY8TbxNye
 jLE1rDfg7l8x1bZdyRhH3b63d1b2cYEtidMwQJQPF+OgNfE2qQ60RA5He7bleiJIsirEt6fO
 1SH82VwIriSuShljo5PUghA3u2H6AKxoiTMJ5khzQU1jHVEkkTSIWd7NevlEIUx7TdHZjYCl
 F2H4D+NbNspFf0dGgMtVEQjp/GLoRmdMOHdsJjPIvlp1KXWrdYobmFCqIbIR9ba7RsNuXD6
IronPort-HdrOrdr: A9a23:9ZIxfKhCtNYc7AoqiLsnzcI74XBQXv4ji2hC6mlwRA09TyVXrb
 HKoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9034033"
X-MGA-submission: =?us-ascii?q?MDFPTOuCjnaXkUD/Dgo9TXqP4RWWAQVz2VpjoQ?=
 =?us-ascii?q?S8UEiDNBdJENz3OytUaVxOCVlHcTmU8Q2Zg/ayEkkRQggq8kqZDpRurt?=
 =?us-ascii?q?8vUqFkDuy6SOMiprYnhNrhE2sOubgpnlCGdqXKvDzyTdVPcpgABkDw1U?=
 =?us-ascii?q?wDOeaggiyMr9mHUBEFtQjC8Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:22:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647710539;
	bh=fpl/zF+x7VSRyO8P+IM50g7x+1HgHEzaFFJK1isaRk0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gutoLqz9nCHqCkktSlNbx1AFvDF3UOSahDuiKn2hPhukOSIhGYCJgtbAoiftFM1Z7
	 ufkw6Rgg9537REwCZuQO3MwFMvo2948UvN1zvdIAEE8iGiL2c94lUA1JxIhhAWeR+6
	 3TM7ChTEose+/3IyLqjpnD0wzpMlQN4+ILX9cDi4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1nPq1c2UuV-0069DH; Sat, 19
 Mar 2022 18:22:19 +0100
Message-ID: <8c8cc0d7-bf6c-060e-c500-5a28e7213703@web.de>
Date: Sat, 19 Mar 2022 18:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
 <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net>
 <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
 <e7182c14-5551-111d-7c41-16fb747fe505@web.de>
 <alpine.DEB.2.22.394.2203191219370.3204@hadrien>
 <869caaec-da7f-36a8-5048-817177756bc7@web.de>
 <7da5a4-cec7-3112-e811-8e427acd1441@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7da5a4-cec7-3112-e811-8e427acd1441@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cFa4qljaz8i0r3ZTYUNeoFNzrXgcWMoFMiwwT6IlctSi9OOVV53
 /QeRHseqzoeAPop1xSo/iTCvbcHPr+Uodl/Sp9k/K08PfKGB1VoWUeqxQ9wq2rFKMIDT3ee
 VO+YA7eNN3NYVIVABeP5SpwWUbVxeuIrzuUWZOdDFuccFHGWV/9j1NpLEtHLkruAY9uGZQk
 Hnm+RKN8ZqPE+5mKcexug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6TDqYCIoYQ8=:rJsFJvRW7JO5AqpK3+dz2j
 7h0yBhN5yQQCuKgyf1y2Pi3gWuvdvHmFS/9vv4olxY0i8+1N/0IrR7sdNUFsgD6GjdyDRoQO5
 RYHkTsXPmRic6zv4wxEv9/yWQAA5klFHCNdB7IndMf386UYV1B/6a/q01SxwkuNlj+zSvH3c4
 KcFrXg988T5eLYCqOKT2lRrXmJafnttm0FgrUdgOon7ClfZfG24HbhZmW9nvCPraHschdAD3+
 iTL0Nnbn3hQ9NuVbYY2syMFd+U0fIyhghr2d/GxWGWyqIymvq2VkypxWujja0MqaFudrhnf7w
 aIUAnHDtUNedjp0qx/PFYEWPqb8rvSzHCnaTumzqmPsbcvkLsQ9wEP+bdcplc2+YAAKsyAIkk
 xsn+UnH0XHgkl+uUMU4JDoJmyDpwzHJGM+A8pAC0dR1TUcqG5pc+wXjmZIDs+CDR+uqsQXrSk
 /R+DQB+SqOOvPxCUmUG3+j/RCJSy/V6AejYGGsrmcCyB9ew9RpXI6uPxIFH8q1P+yk7JLZ4fh
 NxYQmD/GnibS1PDpWsdS4PfV2/e81Mev2o7hHhnqO7vmkEEisatNV4VE5gEV52GvCocBOfHHZ
 tUm7KnS9L58OjjAxmvN85ZK7N83XpzPNvWWDjnQ0qvVV3FOXKCFZuOi3hA2mVUyil0Qy24AUG
 TDThRbB7ssYiK65P3tk1zrpPH3sI0ZZOF3hpG1c8lUhHF/fFjJbIF5HHkGkX5Q4AAEigfNK4t
 mxKMl2F2TbxTLTs2wVTbl85mZvVGARqBdrsEZM/12QpZDcjx2oCaVZc64Y8cBWa9qZH2SVBlH
 ve5Wj94+fVYd2pZbvB+a3m1JDadxgWST/YtTsMGFVHxTBAtvQBOWjOM7g0usTelrsDV3N4kU3
 qs20OFrcRln6Hs3ZlVrko/t7BG1AF5IQRv8yC7UUjHujJuEivyWf1m2PoSF+64cglyOfmshoD
 hV+T/ADRyyCYAE7aTQV9Vk/YiOQR8EBhWib73Tb4d9PFYkpyniqAe3tMGBzX2c/5bygbEYwMc
 PYJlPFYShncNh6zGoeAOiPq6yZFi+ebO8ZZgKZTTZjW0N1EBN5hIOtXDv/dCcfhtr0CTynVsO
 Sx9HKdAPgsJSA4=
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 249
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/8c8cc0d7-bf6c-060e-c500-5a28e7213703%40web.de>

>> * Additional context information for relevant source code places
>>
>> * Non-empty function implementations are probably preferred, aren't the=
y?
> Look closer at later rules in the SmPL.  The empty function definition i=
s
> built out further down.


I noticed this also.

How do you think about to try out if the desired function implementations
can be directly constructed by the SmPL rule =E2=80=9Cr2=E2=80=9D (instead=
 of using an extra
third SmPL rule)?



> That is a placeholder for the compare_T functions
> that hold the all comparisons.


This aspect is reasonable.

I propose to take another look at possibilities for fine-tuning of SmPL co=
de.
Would you like to recheck the need for any SmPL ellipses?

Regards,
Markus

