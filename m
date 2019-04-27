Return-Path: <SRS0=Dpxx=S5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MISSING_HEADERS,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923AC43219
	for <cocci@archiver.kernel.org>; Sat, 27 Apr 2019 17:25:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E629206A3
	for <cocci@archiver.kernel.org>; Sat, 27 Apr 2019 17:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="euxsLjcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E629206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3RHOs2W015380
          ; Sat, 27 Apr 2019 19:24:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF85A773D;
	Sat, 27 Apr 2019 19:24:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BBC47734
 for <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:24:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3RHOp6U028275
 for <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:24:51 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556385891;
 bh=xAN+0pVqDTtW1UGdvb5m1WcdZVYZMjo9yWfiU4jtUxw=;
 h=X-UI-Sender-Class:Subject:From:Cc:References:Date:In-Reply-To;
 b=euxsLjcgQ5+nz5INQb6BytM1O6N4Q2bRzycc/CJkNPTeqNkkN7s/tX4wQ0Z51ZUdj
 8vBJ+iMcNJuGcQHm+E6XHa5PaqAUEC239+0kTIWp6c3hMXmUL9LzNkHT6kgB4gkSq/
 0snODAbCrnxFlyF3Ab2m4xBJJU1iX0AepPyCdjos=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.163.217]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetUp-1h0G4K0Tx1-00qgjF for
 <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:24:51 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Coccinelle <cocci@systeme.lip6.fr>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
 <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
 <alpine.DEB.2.21.1904251039000.2550@hadrien>
 <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6ec5b70f-39c3-79e5-608f-446a870f02f3@web.de>
Date: Sat, 27 Apr 2019 19:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
Content-Type: multipart/mixed; boundary="------------8C28758D7041352EB848416F"
Content-Language: en-US
X-Provags-ID: V03:K1:eq/eOayB+xTlUdZj+03lzUHTFEUZ2JNXtZyuBjfQfGmlVoIEwVK
 JFMRcZRTiquEKhGc0Vr5apFrTxKaL+hycoMrIGV2S9kjMkq/58/BzFBiZFGkMRrSVL9AeYB
 KqX56ZiMHFPoiqHxPG7tF0T15jfQ3GWuZ4nn03Pvc+W/VobUMFxSwYdqlx45HSaqZRGsGB0
 4m5eWiWDrjxe//9asn/PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:td8oUMMasB0=:YjTNqMYckKMwBwUxkapp5M
 SvSWcT48KhfFn5CjPTuFnvDpp1fPvKle81oqOai4MQQwLPiub+Im0BAGzEuYlCIJXh9ykxzyz
 pgML8fmyxNMr/emG30F9x4l1XQpKoBSJaLBmQh3+UIChey1pBT1lw7Vkt3dqMz63Ly7cmHDIw
 LDnrw+eGwfQwum1Hf2FF4jis9C/+yGZ7W2uZ+yN/MG59MK4/XbCzlfNSVf5CNmqLhT9TLXJN8
 KF7PkZx6Mgn2EgXLDh54s4Y7aP7Hx3Nj75yqG6r8EdpkGhch96EMqhcwwl7jk7HvUB1RcYy/m
 UZueF8AFn0JBU/xbuhOhN2WxcZtM5IqJ+e/LpLZlKwdt7LyoiPpxnu2TTU7qVHoSaNpyinGOb
 YlUPjPpfM2hjossJu9aYuJqF1hMa3vlDt4IhevzigDLWHYepZ9VKU5E0iF6lLpYITJGiTFOcM
 FHyEYfTh2Y7Ypx/h8sbUw29m2/G/BwIsVNk5WsCThVabO+qcnTmErSJobv1xgz7ZgSrZQMe4r
 2uJnFIUHmmZ6Y2lT3dQ91dbCiLqpx85AOS2YUvQHXKxN1AH+w3g+vUBJtwoH4JrsXXPPIAEHQ
 Bpqs6xETZbrBn0cY6KLi8DLFHS1ft47Xt+8CcTTm3893vCYDCxSumLVOQwCBkuLZRuLDgOym0
 dY8ossIwFqFoOqKzEhyrsdNPc4PYCXWLvgScv9WoaMhJx7wMwtEvbrxpwnFI/4GeSRd1w4Hj8
 ZRPhqDs6nmsTezQdQtvKn/A3tp1uyksnq3k+ZyQjN4uMZwPUTlC81XCnk3m4NltkIL0cUFKAI
 CYxqMaZFAsqsAW2HRBltikZIwy8HDIxBDjSWgppVgfXLv4gzcL7nkM756somi68Ce4d3lu+zY
 41I4s8hGOuDxvUf3730TQGxPkjbjbtPuvRfGuEsn6md8q0M2skp4k1ePVBqdIn
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 27 Apr 2019 19:24:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 27 Apr 2019 19:24:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Data exchange over network interfaces by SmPL scripts
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------8C28758D7041352EB848416F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> connecting
=E2=80=A6
>   File "<string>", line 35, in store_statements
> socket.gaierror: [Errno -2] Name or service not known
> Error in Python script, line 56, file =E2=80=A6

It seems that the attached adjusted data processing approach can produce
an usable analysis result.

elfring@Sonne:~/Projekte/Coccinelle/janitor> time /usr/bin/python3 list_du=
plicate_statement_pairs_from_if_branches-server4.py
statement1|statement2|"function name"|"source file"|incidence
dprintk ( "%s: readreg error (reg =3D=3D 0x%02x, ret =3D=3D %i)\n" , __fun=
c__ , reg , ret ) ;|return - 1 ;|stv0297_readreg|/home/elfring/Projekte/Li=
nux/next-patched/drivers/media/dvb-frontends/stv0297.c|3
dprintk ( "%s: readreg error (reg =3D=3D 0x%02x, ret =3D=3D %i)\n" , __fun=
c__ , reg1 , ret ) ;|return - 1 ;|stv0297_readregs|/home/elfring/Projekte/=
Linux/next-patched/drivers/media/dvb-frontends/stv0297.c|3

real	0m1,044s
user	0m0,389s
sys	0m0,055s


Unfortunately, I observed during a few runs on my test system
that the displayed record sets can vary. Thus I guess that this approach
(which works together with Python multi-threading functionality) will need
further software adjustments.
Would you like to add any advices here?

Regards,
Markus

--------------8C28758D7041352EB848416F
Content-Type: text/x-python;
 name="list_duplicate_statement_pairs_from_if_branches-server4.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="list_duplicate_statement_pairs_from_if_branches-server4.py"

import threading, socket, socketserver, struct, subprocess
inputs = []

def receive_data(s, n):
    d = b''

    while len(d) < n:
        p = s.recv(n - len(d))
        if not p:
           return None

        d += p

    return d

def receive_message(s):
    expect = receive_data(s, 4)
    if not expect:
       return None

    return receive_data(s, struct.unpack(">I", expect)[0])

class threaded_TCP_request_handler(socketserver.BaseRequestHandler):
    def handle(self):
        data = receive_message(self.request)
        if data:
           inputs.append(data.decode())

class threaded_TCP_server(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass

if __name__ == "__main__":
    server = threaded_TCP_server(("localhost", 1234), threaded_TCP_request_handler)
    with server:
        ip, port = server.server_address
        server_thread = threading.Thread(target = server.serve_forever)
        server_thread.daemon = True
        server_thread.start()
        cp = subprocess.run(["/usr/local/bin/spatch",
                             "--timeout",
                             "9",
                             "--python",
                             "/usr/bin/python3",
                             "-D",
                             "server_id=" + str(ip),
                             "-D",
                             "server_port=" + str(port),
                             "/home/elfring/Projekte/Coccinelle/janitor/list_duplicate_statement_pairs_from_if_branches-client3.cocci",
                             "/home/elfring/Projekte/Linux/next-patched/drivers/media/dvb-frontends/stv0297.c"],
                            capture_output = True, text = True)
        server.shutdown()
        import sys

        if cp.returncode:
           sys.stderr.write("%s\n===\nexit code: %d" % (cp.stderr, cp.returncode))
        else:
           if len(inputs) > 0:
              def report():
                 mapping = {}

                 def insert(x):
                    """Add data to an internal table."""
                    key = x["name"], x["file"], x["line"], x["column"]
                    if key in mapping:
                       sys.stderr.write("""A duplicate key was passed.
function: %s
file: %s
line: %s
column: %d
""" % key)
                       raise RuntimeError
                    else:
                       mapping[key] = x["s1"], x["s2"]

                 def data_import():
                    import json
                    for k in inputs:
                       for v in json.loads(k):
                          insert(v)

                 data_import()
                 from collections import Counter
                 counts = Counter()

                 for k, v in mapping.items():
                    counts[(v[0], v[1], k[0], k[1])] += 1

                 delimiter = "|"
                 duplicates = {}

                 for k, v in counts.items():
                    if v > 1:
                       duplicates[k] = v

                 if len(duplicates.keys()) > 0:
                    sys.stdout.write(delimiter.join(["statement1",
                                                     "statement2",
                                                     '"function name"',
                                                     '"source file"',
                                                     "incidence"])
                                     + "\r\n")

                    for k, v in duplicates.items():
                       sys.stdout.write(delimiter.join([k[0], k[1], k[2], k[3], str(v)])
                                        + "\r\n")
                 else:
                    sys.stderr.write("Duplicate statements were not determined"
                                     " from the following records.\n"
                                     + delimiter.join(["statement1",
                                                       "statement2",
                                                       '"function name"',
                                                       '"source file"'])
                                     + "\r\n")

                    for k, v in counts.items():
                       if v < 2:
                          sys.stderr.write(delimiter.join([k[0], k[1], k[2], k[3]])
                                           + "\r\n")

              report()
           else:
              sys.stderr.write("No result for this analysis!\n")

--------------8C28758D7041352EB848416F
Content-Type: text/plain; charset=UTF-8;
 name="list_duplicate_statement_pairs_from_if_branches-client3.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="list_duplicate_statement_pairs_from_if_branches-client3.cocc";
 filename*1="i"

QGluaXRpYWxpemU6cHl0aG9uQApzX2lkIDw8IHZpcnR1YWwuc2VydmVyX2lkOwpzX3BvcnQg
PDwgdmlydHVhbC5zZXJ2ZXJfcG9ydDsKQEAKaW1wb3J0IGpzb24sIHNvY2tldCwgc3RydWN0
LCBzeXMKCmlmIHNfaWQgPT0gRmFsc2U6CiAgIHNfaWQgPSAibG9jYWxob3N0IgoKdGFyZ2V0
ID0gc19pZCwgaW50KHNfcG9ydCkgaWYgc19wb3J0IGVsc2UgMTIzNApzeXMuc3RkZXJyLndy
aXRlKCJVc2luZyBQeXRob24gdmVyc2lvbjpcbiVzXG4iICUgKHN5cy52ZXJzaW9uKSkKc3lz
LnN0ZGVyci53cml0ZSgnQ29ubmVjdGlvbnMgd2lsbCBiZSB0cmllZCB3aXRoIHNlcnZlciDi
gJwlc+KAnSBvbiBwb3J0IOKAnCVk4oCdLlxuJwogICAgICAgICAgICAgICAgICUgdGFyZ2V0
KQoKZGVmIHN0b3JlX3N0YXRlbWVudHMoZnVuLCBzb3VyY2UsIHMxLCBzMik6CiAgICAiIiJT
ZW5kIGRhdGEgZm9yIHRoZSBzZXJ2aWNlLiIiIgogICAgcmVjb3JkcyA9IFtdCgogICAgZm9y
IHBsYWNlIGluIHNvdXJjZToKICAgICAgIHJlY29yZHMuYXBwZW5kKCd7Im5hbWUiOiVzLCJm
aWxlIjolcywibGluZSI6JXMsImNvbHVtbiI6JXMsInMxIjolcywiczIiOiVzfScKICAgICAg
ICAgICAgICAgICAgICAgICUgKGpzb24uZHVtcHMoZnVuKSwKICAgICAgICAgICAgICAgICAg
ICAgICAgIGpzb24uZHVtcHMocGxhY2UuZmlsZSksCiAgICAgICAgICAgICAgICAgICAgICAg
ICBqc29uLmR1bXBzKHBsYWNlLmxpbmUpLAogICAgICAgICAgICAgICAgICAgICAgICAganNv
bi5kdW1wcyhpbnQocGxhY2UuY29sdW1uKSArIDEpLAogICAgICAgICAgICAgICAgICAgICAg
ICAganNvbi5kdW1wcyhzMSksCiAgICAgICAgICAgICAgICAgICAgICAgICBqc29uLmR1bXBz
KHMyKSkpCgogICAgd2l0aCBzb2NrZXQuc29ja2V0KHNvY2tldC5BRl9JTkVULCBzb2NrZXQu
U09DS19TVFJFQU0pIGFzIHNvOgogICAgICAgIHNvLmNvbm5lY3QodGFyZ2V0KQogICAgICAg
IHJlc3VsdCA9ICJbXG4iCiAgICAgICAgcmVzdWx0ICs9ICIsXG4iLmpvaW4ocmVjb3JkcykK
ICAgICAgICByZXN1bHQgKz0gIlxuXSIKICAgICAgICBiID0gYnl0ZXMocmVzdWx0LCAidXRm
OCIpCiAgICAgICAgcCA9IHN0cnVjdC5wYWNrKCI+SSIsIGxlbihiKSkKICAgICAgICBwICs9
IGIKICAgICAgICBzby5zZW5kYWxsKHApCgpAc2VhcmNoaW5nIGV4aXN0c0AKaWRlbnRpZmll
ciB3b3JrOwpzdGF0ZW1lbnQgczEsIHMyOwpwb3NpdGlvbiBwb3M7CnR5cGUgVDsKQEAKIFQg
d29yayguLi4pCiB7CiAuLi4gd2hlbiBhbnkKIGlmICguLi4pCiB7CiAuLi4gd2hlbiBhbnkK
IHMxQHBvcwogczIKIH0KIC4uLiB3aGVuIGFueQogfQoKQHNjcmlwdDpweXRob24gY29sbGVj
dGlvbkAKZnVuIDw8IHNlYXJjaGluZy53b3JrOwpzMSA8PCBzZWFyY2hpbmcuczE7CnMyIDw8
IHNlYXJjaGluZy5zMjsKcGxhY2UgPDwgc2VhcmNoaW5nLnBvczsKQEAKc3RvcmVfc3RhdGVt
ZW50cyhmdW4sIHBsYWNlLCBzMSwgczIpCg==
--------------8C28758D7041352EB848416F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------8C28758D7041352EB848416F--
