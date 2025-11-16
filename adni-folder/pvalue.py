import csv
import re
import pandas

print("ok so basically this program lets you see all the significant things")
filename=input("whats the file name \n")
reference=pandas.read_csv(input("whats the name of the file that you used to get this file \n"),
            index_col=0, nrows=0).columns.tolist()

# reference=re.sub('\'','',str(reference))
all_results=[]
plist=["PTGENDER_name","PTEDUCAT_name","age","g1","g2","g3","apoe4","age:g1",
       "age:g2","age:g3"]
idk="Correlation"
flag=0
result={}
#all_results=[result]
data=open(filename,'r')
for line in data:
    line=line.rstrip()
    if line in reference:
        flag=1
        # print(line)
        colname=line
        result["ID"]=colname
        # print("result is")
        # print(result)
            # print(colname)
    elif idk in line:
        flag=0
        all_results.append(result)
        result={}
    elif flag==1:
        pvalues=line.split()
#        print("pvalue is")
#        print(pvalues)
        if len(pvalues) > 5:
            name=pvalues[0]
            if name in plist:
                # print(pvalues)
                pvalue=pvalues[5]
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
