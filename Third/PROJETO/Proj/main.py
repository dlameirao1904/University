from data import campos
from adlds import newfield

def main():
    print("Os seguintes programas devem imprimir os campos de todos os ficheiros, e, seguidamente imprimir os campos comuns")
    files = ["datasets/atco1_acordaos.json","datasets/jcon_acordaos.json","datasets/jtca_acordaos.json","datasets/jdgpj_acordaos.json", "datasets/jtcampca_acordaos.json","datasets/jtcampct_acordaos.json","datasets/jsta_acordaos.json","datasets/jstj_acordaos.json","datasets/jtcn_acordaos.json","datasets/jtrc_acordaos.json","datasets/jtre_acordaos.json","datasets/jtrg_acordaos.json","datasets/jtrl_acordaos.json","datasets/jtrp_acordaos.json"]
    print("in:",files)
    print("out1: no ficheiro output1.json\n", campos(files))
    print("\nout2: no ficheiro output2.json")
    newfield(files)

if __name__ == '__main__':
    main()

