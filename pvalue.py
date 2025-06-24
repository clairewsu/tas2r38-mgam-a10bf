import csv
import re
import pandas

print("ok so basically this program lets you see all the significant things")
filename=input("whats the file name \n")
file2="/home/claire/projects/rosmap/data/annotation/chr7.gene.txt"

reference=[]
data2=open(file2,'r')
for line in data2:
   line=line.rstrip()
   reference.append(line)
   
data2.close()
# print(reference)
# reference=re.sub('\'','',str(reference))
all_results=[]
plist=["msex","educ","RIN","pmi","age_death","get(aa)","apoe4"]
idk="Residual standard error"
idk2="Coefficients:"
flag=0
result={}
#all_results=[result]
data=open(filename,'r')
for line in data:
  if line.strip():
    line=line.rstrip()
    if line in reference:
        # print(line)
        colname=line
        result["ID"]=colname
#        print("result is")
#        print(result)
            # print(colname)
    elif idk in line:
        flag=0
        all_results.append(result)
        result={}
    elif idk2 in line:
        flag=1
    elif flag==1:
        pvalues=line.split()
#        print("pvalue is")
#        print(pvalues)
#        if len(pvalues) > 5:
        name=pvalues[0]
        if name in plist:
                # print(pvalues)
           pvalue=pvalues[4]
           result[name]=pvalue
                # print ("updated result is")
                # print(result)
#                all_results.append(result)
                # print(result)
                

data.close()

# print(all_results)

print("\n ok so now it came out with your thing")
outputfilename=input("what do u want to name the output file \n")
fieldnames=all_results[0].keys()

with open(outputfilename,'w',newline='\n') as convert_file:
    writer=csv.DictWriter(convert_file, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(all_results)
# =============================================================================
