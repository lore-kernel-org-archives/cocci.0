From: wagi@monom.org (Daniel Wagner)
Date: Mon, 29 Jul 2013 10:33:23 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <alpine.DEB.2.02.1307281248230.2028@localhost6.localdomain6>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307281248230.2028@localhost6.localdomain6>
Message-ID: <51F628D3.6050903@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 07/28/2013 12:48 PM, Julia Lawall wrote:
> On Wed, 17 Jul 2013, Daniel Wagner wrote:
>
>> Hi,
>>
>> I have found another small issue. Not a big thing. I have following rule
>>
>> @@
>> identifier f =~ "^(__)?connman_.*" ;
>> @@
>>
>> f(...,
>> (
>> - FALSE
>> + false
>> |
>> - TRUE
>> + true
>> )
>>   ,...)
>>
>>
>> And this little C example:
>>
>> bool __connman_bar(bool baz);
>> int connman_foo(int val, bool bar);
>>
>> int main(int argc, char *argv)
>> {
>> 	int err;
>>
>> 	if (__connman_bar(FALSE) == TRUE)
>> 		err = connman_a_rather_long_line(2434, TRUE);
>>
>> 	return 0;
>> }
>>
>>
>> Running coccinelle on this results in the not so nicely formated patch:
>>
>> @@ -5,8 +5,9 @@ int main(int argc, char *argv)
>>   {
>>          int err;
>>
>> -       if (__connman_bar(FALSE) == TRUE)
>> -               err = connman_a_rather_long_line(2434, TRUE);
>> +       if (__connman_bar(false) == TRUE)
>> +               err = connman_a_rather_long_line(2434,
>> +                                                                         true);
>>
>>          return 0;
>>   }
>>
>> When connman_a_rather_long_line() is not sooo long then it works as
>> expected, that means not additional line is introduced. Any ideas
>> what is going wrong?
>
> A patch is below.

Patch works. Thanks.

cheers,
daniel
