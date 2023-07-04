{******************************************************************************}
{                                                                              }
{                                  Delphereum                                  }
{                                                                              }
{             Copyright(c) 2018 Stefan van As <svanas@runbox.com>              }
{           Github Repository <https://github.com/svanas/delphereum>           }
{                                                                              }
{             Distributed under GNU AGPL v3.0 with Commons Clause              }
{                                                                              }
{   This program is free software: you can redistribute it and/or modify       }
{   it under the terms of the GNU Affero General Public License as published   }
{   by the Free Software Foundation, either version 3 of the License, or       }
{   (at your option) any later version.                                        }
{                                                                              }
{   This program is distributed in the hope that it will be useful,            }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of             }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              }
{   GNU Affero General Public License for more details.                        }
{                                                                              }
{   You should have received a copy of the GNU Affero General Public License   }
{   along with this program.  If not, see <https://www.gnu.org/licenses/>      }
{                                                                              }
{******************************************************************************}
// Delphereum Study. Tutorial 'Transferring Ether with Delphi'
// Project in Delphi made with source of this tutorial: https://medium.com/@svanas/transferring-ether-with-delphi-b5f24b1a98a4
// Prepared by Valient Newman <valient.newman@proton.me>
// source: 
// My Github Repository <https://github.com/valient-newman>

unit TransferringEtherWithDelphiUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  web3, web3.eth, web3.eth.tx, web3.eth.utils, web3.eth.types;

procedure TForm1.Button1Click(Sender: TObject);
begin
web3.eth.tx.sendTransaction(
  TWeb3.Create(Ganache),                                                           // Ganache 2.7.1
TPrivateKey('24622d680bb9d6d80c4d3fb4b4818e738de64b521948b1b1c85616eeeda54ee1'),   // from private key
  '0xaDDcedc01C1070bCE0aF7eb853845e7811EB649C',                                    // to public key
  web3.eth.utils.toWei('0.01', ether).Value,                                       // 0.01 ether
  procedure(tx: TTxHash; err: IError)
  begin
    TThread.Synchronize(nil, procedure
    begin
      if Assigned(err) then
        MessageDlg(err.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0)
      else
        MessageDlg(string(tx), TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    end);
  end
);
end;

end.
