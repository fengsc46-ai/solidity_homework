// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
合约包含以下标准 ERC20 功能：
balanceOf：查询账户余额。
transfer：转账。
approve 和 transferFrom：授权和代扣转账。
使用 event 记录转账和授权操作。
提供 mint 函数，允许合约所有者增发代币。
*/

interface IERC20 {
    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 获取总供应量
    function totalSupply() external view returns (uint256);

    // 获取账户余额
    function balanceOf(address account) external view returns (uint256);

    // 转账
    function transfer(address to, uint256 amount) external returns (bool);

    // 获取授权金额
    function allowance(address owner, address spender) external view returns (uint256);

    // 授权
    function approve(address spender, uint256 amount) external returns (bool);

    // 转账
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}


contract ERC20Task is IERC20 {

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 public decimals = 18;
    address public owner;

    mapping (address account => uint256 balance) balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

     constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        owner = msg.sender;
    }

     function allowance(address ownerAccount, address spenderAccount) external view override returns (uint256) {
        return _allowances[ownerAccount][spenderAccount];
     }

    function balanceOf(address account) external view override returns (uint256){
        return balances[account];
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }
    function transfer(address to, uint256 amount) external override returns (bool){
        require (amount != 0,"");
        require(balances[msg.sender] >= amount, "");
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external override returns (bool){
        require(owner != address(0),"");
        require(owner != spender, "");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external override returns (bool){
        require(from != to,"");
        require(balances[from] >= amount, "");
        require(_allowances[from][msg.sender] >= amount, "");
        balances[from] -= amount;
        balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address account, uint256 amount) public {
        balances[account] = amount;
        _totalSupply += amount;
        emit Transfer(address(0), account, amount);
    }
}