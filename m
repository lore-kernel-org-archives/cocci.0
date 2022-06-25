Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BA0C43334
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kLCYuu1xgjhh9IKsAoE3emGKul3A3CISeJ+8dqzjUeY=;
  b=ovO1vGEX1YCdpmciiCsZ6MxhdBbbdN3CD6NQqaH4w3fpXQw0oAxXU30Y
   HTEH8pKzX4fFX5ADnQAElIhfHkFXTvgTc9ResbRcHdQT3B8ZSVqZnhsVh
   NA6STXvKr3pCC+4AU6Lp2bvBcWuWM9eiPSh8uz/qh+WK71m7V0oYkD13r
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208,217";a="42852002"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 20:00:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9CEEE00CA; Sat, 25 Jun 2022 20:00:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27C09E00BE
	for <cocci@sympa.inria.fr>; Sat, 25 Jun 2022 20:00:15 +0200 (CEST)
IronPort-SDR: m/c2sW5U7+4vwONkQXnaGP3KVhbWqiFcwIC0f5VZUiBgPxZkl6RsXGUTg4gr2SsgpdAD08faAQ
 Ol7KyDgg6AlXlERqWNq/wFBPEBI85fFOT9uFA2T5ifbftaAImzHsqet3qpuOl5xs9CXUpfIK6V
 eY4yqObmGjyufRGQXzbA3vLcoEvEfjMnfjwEeRgrhW5co0BKDkNPL52vH6YVxVuo8F8lXvpIfs
 4CnQMHDsSnTyqPsmlSXlhmeSsgUMc/XiN+mSCl9oZC2Ne7DCZgrPEC4LqjDXDW3x2EpZt8sqJO
 4XzH8WOZWKD8JV/Qehw9eAMO
X-IPAS-Result: =?us-ascii?q?A0BrAgCVTLdif7OAVdFagliCJIFWLwQLRIROgSONRY0oL?=
 =?us-ascii?q?wKBBJA9gXwLAQMBDUIEAQGKTwIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgU8lCwMxDYI1IoQEE?=
 =?us-ascii?q?R0BGx4DEgMGAQY3AiQBEQEFAVeFQAEDMAOPQIx9gh+BBEKLMoEVBReBAYIJB?=
 =?us-ascii?q?oRMChkoDWcDgVkCBxKBK4YfgSwBAYdSgimBS4JEhX+DCYJlBJklBAcDBAEEA?=
 =?us-ascii?q?QYOAwMCIgECAUYjAQEKAgYGBAYDAQEGAwkCBAISAgIEBxcKEggUAwIFAQIfB?=
 =?us-ascii?q?QEHBQMDEgYMEQEIBgYBBAIKAQICBQUMAwERAwIGAgQEBBgUBAIEBwYCCQkHB?=
 =?us-ascii?q?RYLBAoCFgEbAgYMCAICAgICBBQHAQ0FAgIEDwIHBgMLAgMFBwMDBAcCCgQMD?=
 =?us-ascii?q?gEDAQcBBAUDDQQBAQYCAQgDBQoCAQICAQwBAQEGAgIIAQECAgMGAgEEAgcBA?=
 =?us-ascii?q?gUDAgMIAwIDAwIBAQQICAIHAwQCAwEFAQUDAgUBAwMCAQMDAwIBBAMGCQoEC?=
 =?us-ascii?q?AEEBAEBARECBwcCBgMDAgICAgUBAg0BAgECBAMGBgIDFAECBAEKAQUCAwkCB?=
 =?us-ascii?q?wMBAQIGBQoCBwUCBwICBAEFAw0BAwUCAwEBAwMCBAECAQEDCAEDAgMDAgICA?=
 =?us-ascii?q?gUCAwICAgkDBAEHAwIBAQQFAQQDAQIKBAQDBAIEAgcCBwIEBwIBAgYDBwYBA?=
 =?us-ascii?q?wIBBwEBBAoEAwMDAQcBAgUCAgMCBhIGBwIEAQMEBAoCAgsCAQYBAQIBAQEBA?=
 =?us-ascii?q?gMCBwUMAQEBAwIDBgIFAgIBAQMICAMCAQQBBQMBBAUDBwIBBQYCCQMDCQMBA?=
 =?us-ascii?q?QUBAwEJAwMDAgkDAQIMBAMIAwMCAwQCAgICAQMCBwUIBAEECQICAgECAgYCA?=
 =?us-ascii?q?QMaAQIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCDgYBAQEBA?=
 =?us-ascii?q?gMDAQIDAQYHAggCMxMBAwMDAgIFAgIBAgMCAg0BAQEEAgECAQIGAQMBAgIDA?=
 =?us-ascii?q?QMBAgIGAgwJAgcBBQMDAgIDAQEFDwUCBAIBAgYFAgEBAQQBAwQEBgICAQMDA?=
 =?us-ascii?q?g4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBAQEFAQIBAQQCB?=
 =?us-ascii?q?AQBBgoDAgIEAwMFAQECAwIBAQEHDAICAhMCEwMBBgEDCwUBEwMCBAICAQICC?=
 =?us-ascii?q?gIBAQICAQMCCQIBAgEFCBgDAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNA?=
 =?us-ascii?q?wIDCAwCCQMCAQMFAwICBAECBAwKAQICAQICBAUFAgECAQgDAQUKAwUJBQIEA?=
 =?us-ascii?q?QECAQMIBAMLBgIFAgECAwUDAwIBCgUCAwECAQEDBAEDBAYBAQIDAgIBBgICA?=
 =?us-ascii?q?QEDAwQDAQIEAgICBwIDAgEEAgECAwEBAQQCAgICAgMDCAMCAQgHBQECBAECA?=
 =?us-ascii?q?QQDAgIBAgcBAgIBCQIBAwMFAwQBAwcDDwMFAwEDAwIFEAMBBgUBAgIBAgICA?=
 =?us-ascii?q?gQCCQIEBQIFAwIEAgMDAgIIAwIDAQIBAgkEAwIGAgEEAgUDBAsEAwQCAwICB?=
 =?us-ascii?q?QICAgICBQICAwECAgICAgIFAgMBBAEFAQICAgECAgIEAQICBwQCAwEDBA4DA?=
 =?us-ascii?q?wQCAgcBAgIBBgECBwMBAgEEAwEBBAICBAECAgUCAQMBBAEDAQICBwIDAQMKA?=
 =?us-ascii?q?gIDAgEBAgMDAgMFAwQECAQFAgMDBQICBQEBBQYnAQZkm3wTTC2DAAEBAZFAk?=
 =?us-ascii?q?CueGCEJAQYBAYIidA0tgUSeUjGoZJZwpy4QIxKBLGeBLjMaI4EBbYFKTgECA?=
 =?us-ascii?q?QEBDQECAQEDAQIBAgkBAQKSD4phQTE7AgYBCgEBAwmPAQEB?=
IronPort-PHdr: A9a23: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
 50LGOYzvLkdGfYTC0AjF9sHcs8fYw==
IronPort-Data: A9a23:AG2anaKreY9xzDLPFE+R6ZMlxSXFcZb7ZxGr2PjKsXjdYENSgmEEn
 zRKDzzSOP2OZmb2L9twO9nj/EMPucCHxtUwHVMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M58wIFqtQw24LhXVnQ4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhg9Ypj
 5ZJk6CMdTwEO5+Tk/49UhRyKnQrVUFG0OevzXmXtMWSywjXbCKpzawxXQc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvmuL9E7Y97iggBJGD0Ic3vmxrzDjfS+4hWZ3YSLiTtYBw0zI5h8QIFvHbD
 yYcQWMwM0qcOkQeUrsRIJEiv+e4jVe4SA9Vrm2n+JUTyVGNkgMkhdABN/KMIoDQLSlPpW6To
 WnN/kziExQCPZqezyCE+zSinIfycTjTXYsTEPip6acvjgTMlyocDxoZUVb9qv684qKjZz5BA
 1ASom1tqY4OyHCQY9zPABaigH+JlCdJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaWCkeFWxCO
 rihz4OBONB/jFGGYSnCqerM/FteLQBQfDBSP3ZVJecQy4C7+Nlbs/7Zcjp0/EeIYjDdHDjxx
 3Wbs3F7iexM3IgE0KK0+V2BiDWpznQocuLXzlWLNo5GxlkhDGJAW2BOwQaAhRqnBNjFJmRtR
 FBex6CjABkmVPlhbhClTuQXB62O7P2YKjDailMHN8B/qmr1qiP/JtgBsWoWyKJV3iAsKW+Bj
 Kj76VM52XOvFCbCgVJfON/uV5xxkcAM6/y8BqqNPrKinaSdhCfepH00DaJh92/ql0conMkC1
 WSzIK6R4YIhIf0/llKeHr9DuZdyn3xW7T6NGPjTkkv/uZLDNSb9YepUazOmM7FphIva+lm92
 4gEbKOilU4PONASlwGNrub/23hRfSZlbX03wuQLHtO+zv1ORDx9UqKBnel5E2Gn9owM/tr1E
 riGchcw4DLCabfvcG1ms1hvN+HiW4hRt3U+MXB+NFqkwSlxboOm7aNZfJwyJOF1+OtmxP9yb
 v8EZ8TQWqQVGmqbo2wQPcvnsYhvVBW3ngbRbSeoZT4IeZQ/FQHE/9nTeBTiqXsVBS2tuMpi+
 LCtj1uJQZcKSwl4ItzRbfajkwG4sXQHybB9WkLJJp9Yf0C1qNpmLCn4j/kWJcAQKEWblmHKi
 VrOWRpB/LvDuY449tXNlJuolYbxHrssBFdeEkna8a2yanvX82+l9olKD7SFcDXbY2Xrofnwa
 OhQycb8B/0JhlN9tYRxTuRwxqUk6tqz/rJXw1g2HHjPaFj3WLpsLmPcgZtKv6xJg65G4E64A
 x3evNZdPrqNNYXuF1tIfFgpaeGK1Pc1nDjO7KRqfB+runcvpLfXA19POxSsiTBGKOcnOo0Sx
 +p86tUd7Bayi0Z3P9va3DpY8X+Aci4JX6k97M1IBYbqjk861QgHb8WDW2n555aAb9gKOU4ve
 2fGiK3HjrVa50zDb3tjSiSXjLQF3cwD6EJQ0VsPB1WVgd6Z1PU56xtcrGYsRQNPwxQbju9+N
 wCH7aGuyXliItupuCRCY4xoMwRIBRnc61OojlVQyzyfQE6vWWjAamY6PI5hOazfH310JlBmE
 HOwkQ4JkgoGuOn+2yIzXQhurPmLoRlZ6FjZgM7+dyiaN8BSXNcm65NCoUIHrhLmBYU6g0ivS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:fxNxmKwXW7Jm8HCnGbklKrPwIb1zdoMgy1knxilNoH1uA6ulfq
 WV9sjzuiWE6wr5NEtBpTniAsi9qBHnhPxICOAqVN/IYOCMghrMEGgN1/qH/9QiIUHDHyxmuJ
 uIv5IQNDQ4NzZHsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208,217";a="17764119"
X-MGA-submission: =?us-ascii?q?MDGx6iUj8qoJceGUDqLo7fvQV/oYGQy/TTnVgd?=
 =?us-ascii?q?oRnioLV9xWxUh1Dorij821XNpeulEis78YLLgoke7eyXi0VR5A3Cs6im?=
 =?us-ascii?q?96cQV0XeP9dXeSHwE5yZhdUTpa9qH2u3u2Tep5yndV0QIT2fqy16X//x?=
 =?us-ascii?q?LAMBkUhDGPyOJbVXP7VZLvlQ=3D=3D?=
Received: from mail-yw1-f179.google.com ([209.85.128.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 20:00:14 +0200
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-317710edb9dso52206777b3.0
        for <cocci@inria.fr>; Sat, 25 Jun 2022 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=kLCYuu1xgjhh9IKsAoE3emGKul3A3CISeJ+8dqzjUeY=;
        b=GuQjWTijwMZ9atcgiDfc/dK/JWt6ZbZaUl3Ax4UY92S+ZoI2OY6/mvQSybEexBAYZp
         b9GEL7IdiRlIU7PHjEZruvITw9CYVR/y7k1jLYDyKVnec26IOlvqNYw5wBEBVy1DbZKu
         aIjo+dbpYAUMXJCVNn3t/XPzOPFrPo6D/LotFeOFD9XEs/lJavf1fu3iP6NGy7W81Kfz
         gNAfqZupI9vclM+VHSwzaXt66luxDzzUTzLFY/SJXV5Xa0T0zd461Fj9o3CkLJSm83Od
         Ff9M8S8TD0JDLLGlTf8KPYM/uz7T1z513Q0Dwrnf005YX71/m6WodWUUIxusBDccsyqK
         rxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kLCYuu1xgjhh9IKsAoE3emGKul3A3CISeJ+8dqzjUeY=;
        b=ZT0rthVAQydvHHaS/EhWq/Ho06vmKuXZkjVf65VHoQzJHgc8kVUIssXyeunobz/rKX
         JwM92wOQaThufV09wgaAbYMgphJyLnTxZP6dRfQ3f0OOdg2RjWsRsBbYgOBQdTrQ5uIk
         I8aAHMpC3BMlxz10EsSWk0agjnUUjd2meqvcIWLD0X+/PkoRBHZeRsNd9ZpYrVSG9YQ0
         vjFM7dn3n7Hm0WrtneBqiwieMsTQwziPvt3+7xffvsTBjHrEYCuUU/NEJF9HaaB1IQ7o
         ugYGgYDpTb71o3z7joyEM9hTHPqiQ9OK5mphwPmUiYCooM2JbIplaFydIELZAfVbthjM
         +CPg==
X-Gm-Message-State: AJIora+BjvlYrUeF/OAW7JcLiHHQVk2Mvoh/d+Xeb6ti17wT9rvLLTVv
	YXgxEKt62c1pBHhqFWfvYyAEzmNFvuo/CAjFQpGhSVKT0Q8=
X-Google-Smtp-Source: AGRyM1sPLmH0KiqHJcIxlb95sJeT0Ckt83kffmyym3KFQMb7Y1ZWfTp/sSv4nz9KbJuYQlQTGSHQ7E4j7ejVBb4N+YM=
X-Received: by 2002:a81:4a83:0:b0:318:4fb9:ddc3 with SMTP id
 x125-20020a814a83000000b003184fb9ddc3mr5605026ywa.191.1656180012472; Sat, 25
 Jun 2022 11:00:12 -0700 (PDT)
MIME-Version: 1.0
From: Lucian Popescu <lucian.popescu187@gmail.com>
Date: Sat, 25 Jun 2022 21:00:01 +0300
Message-ID: <CAEUDFgXAX=0ECa4Um9uOzRCBtF2arHjTAF+Kp_UAvkzEafboOg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000053ddcb05e24975f6"
Subject: [cocci]  Coccinelle does not parse macros ending in a comma
Reply-To: Lucian Popescu <lucian.popescu187@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 459
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/CAEUDFgXAX%3D0ECa4Um9uOzRCBtF2arHjTAF%2BKp_UAvkzEafboOg%40mail.gmail.com>

--00000000000053ddcb05e24975f6
Content-Type: text/plain; charset="UTF-8"

Hi,

I ran spatch --parse-c on the following code:

#define something 0,

int main() {
    return 0;
}

This code compiles fine according to the C standard, however the output of
spatch is:

init_defs_builtins: /usr/local/lib/coccinelle/standard.h

PARSING: test.c
ERROR-RECOV: found sync end of #define, line 1
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 1
parse error
 = File "test.c", line 1, column 20, charpos = 20
  around = '',
  whole content = #define something 0,
badcount: 0
BAD:!!!!! #define something 0,
-----------------------------------------------------------------------
maybe 10 most problematic tokens
-----------------------------------------------------------------------
something: present in 1 parsing errors
example:

       #define something 0,

-----------------------------------------------------------------------

Is this a known limitation? If not, is there a way to solve this issue?

Lucian

--00000000000053ddcb05e24975f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I ran spatch --parse-c on the follo=
wing code:</div><div><br></div><div>#define something 0,<br><br>int main() =
{<br>=C2=A0 =C2=A0 return 0;<br>}<br></div><div><br></div><div>This code co=
mpiles fine according to the C standard, however the output of spatch is:</=
div><div><br></div><div>init_defs_builtins: /usr/local/lib/coccinelle/stand=
ard.h<br><br>PARSING: test.c<br>ERROR-RECOV: found sync end of #define, lin=
e 1<br>parsing pass2: try again<br>ERROR-RECOV: found sync end of #define, =
line 1<br>parse error <br>=C2=A0=3D File &quot;test.c&quot;, line 1, column=
 20, charpos =3D 20<br>=C2=A0 around =3D &#39;&#39;,<br>=C2=A0 whole conten=
t =3D #define something 0,<br>badcount: 0<br>BAD:!!!!! #define something 0,=
<br>-----------------------------------------------------------------------=
<br>maybe 10 most problematic tokens<br>-----------------------------------=
------------------------------------<br>something: present in 1 parsing err=
ors<br>example: <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0#define something 0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>-----------------=
------------------------------------------------------</div><div><br></div>=
<div>Is this a known limitation? If not, is there a way to solve this issue=
?</div><div><br></div><div>Lucian</div></div>

--00000000000053ddcb05e24975f6--
