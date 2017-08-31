From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Thu, 31 Aug 2017 16:56:27 +0100
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <WM!a89a77e54968f94897ce9cfdcde91fbafe11503103440c35bc96b5b7348b143240bee9daf49db5256b5b922355576b8f!@mailstronghold-1.zmailcloud.com>
References: <WM!d9b0a1156da6c99c9820ebef21a59a8a89d121069b7a3992c73cc9e3056bf05f3193ceae9e855747b5cba0f4c7a73e77!@mailstronghold-3.zmailcloud.com>
 <20170830125059.eqlq4w54oz57azum@eos.mistotebe.net>
 <alpine.DEB.2.20.1708301504210.3184@hadrien>
 <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
 <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311602290.6822@hadrien>
 <WM!dd59490e5b7de329073fb77c10065fccac3a9a41edb3acd8e86e03476c313ec5bb332d1b5b82bbc9f3c9941991f2c2e3!@mailstronghold-1.zmailcloud.com>
 <20170831154634.apai7ml2mdrf7ua4@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311748110.6822@hadrien>
 <WM!a89a77e54968f94897ce9cfdcde91fbafe11503103440c35bc96b5b7348b143240bee9daf49db5256b5b922355576b8f!@mailstronghold-1.zmailcloud.com>
Message-ID: <20170831155625.wypqab6gers4w4a7@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 31, 2017 at 05:52:14PM +0200, Julia Lawall wrote:
> On Thu, 31 Aug 2017, Ond?ej Kuzn?k wrote:
>> Yes, that has worked quite well actually. It has caused one problem,
>> though, splitting it up has made coccinelle strip curly brackets all
>> over the place, which is a bit problematic in places like this:
>>
>> if (...) {
>>     /* comment */
>>     Debug( ... );
>> }
>>
>> turning it into something very hard to read, especially if there is an
>> else branch:
>>
>> if (...)
>>     /* comment */
>>     Debug( ... );
> 
> So you want to drop the braces if there is no comment and keep the brace
> if there is a comment?  You can't match on comments.  The only thing you
> could do is check the number of lines between the { and Debug.

Something slightly different, I want to remove the braces only if they
do not "belong" to an if statement.

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
