// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _msgValue() internal view virtual returns (uint256) {
        return msg.value;
    }
}
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract Presale is Ownable {

    using SafeERC20 for IERC20;

    struct PresalePool {
        bool open;
        uint256 price;
        uint256 hardCap;
        uint256 lockTime;
        uint256 collected;
    }

    struct PresaleWallet {
        bool inPresale;
        uint256 amount;
        uint8 txCount;
        uint256 tokenAmount;
        uint256 collectAmount;
        uint256 numOfCollectTX;
    }

    PresalePool[] public presalePool;
    mapping(uint256 => mapping(address => PresaleWallet)) public presaleWallet;

    uint256 oneMonth = 60*60*24*30;

    uint256 public denominator = 100;

    uint256 totalPrivateCap = 1000000*10**18;

    uint256 public totalCollected;
    uint256 public tokensSold;
    uint256 public txCount;
    
    uint256 public idoTime;

    IERC20 private immutable _BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
    IERC20 private immutable _USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 private _rogonToken;

    event DepositSuccessful(uint256 _depositAmount, uint256 _tokenAmount);
    event ClaimSuccessful(uint256 _tokenAmount, uint256 _claimableCycles);
    event RoundStatusChanged(uint256 _pid, bool _value);

    constructor () {
        initializePool(10, 200000*10**18, 60*60*24*30*3);
        initializePool(20, 1000000*10**18, 60*60*24*30*6);
        initializePool(36, 1000000*10**18, 60*60*24*30*12);
        initializePool(40, 1000000*10**18, 60*60*24*30*9);
        initializePool(44, 1000000*10**18, 60*60*24*30*6);
        initializePool(80, 100000*10**18, 0);
    }
    
    /// @return deposit token address
    function busd() internal view virtual returns (IERC20) {
        return _BUSD;
    }

    function usdt() internal view virtual returns (IERC20) {
        return _USDT;
    }
    
    /// @return presale token address
    function rogonToken() public view virtual returns (IERC20) {
        return _rogonToken;
    }

    function setROGONAddress(IERC20 _token) public onlyOwner {
        _rogonToken = _token;
    }

    // If deposit BUSD token, then send busd_ 'true', if USDT - 'false'

    function privateRound(uint256 _pid, uint256 _depositAmount, bool busd_) public {
        PresalePool storage pool = presalePool[_pid];
        PresaleWallet storage user = presaleWallet[_pid][msg.sender];
        require(pool.open, "Pool is closed");
        if(_pid < 2 || _pid == 5) {
            require(pool.collected + _depositAmount < pool.hardCap, "HardCap would be exceeded");
        } else if (_pid >= 2 && _pid <= 4) {
            uint256 privateCollected = presalePool[2].collected + presalePool[3].collected + presalePool[4].collected;
            require (privateCollected + _depositAmount <= totalPrivateCap, "Hardcap would be exceeded");
        }

        if (busd_) {
            busd().safeTransferFrom(_msgSender(), address(this), _depositAmount);
        } else {
            usdt().safeTransferFrom(_msgSender(), address(this), _depositAmount);
        }

        user.inPresale = true;
        user.amount += _depositAmount;
        user.txCount ++;
        user.tokenAmount += _depositAmount * denominator / pool.price;
        user.collectAmount = user.tokenAmount / 10;
        user.numOfCollectTX = 0;

        totalCollected += _depositAmount;
        tokensSold += _depositAmount * denominator / pool.price;
        txCount ++;
    }

    function initializePool(uint256 _price, uint256 _cap, uint256 _lockTime) internal {
        presalePool.push(PresalePool({
            open: false,
            price: _price,
            hardCap: _cap,
            lockTime: _lockTime,
            collected: 0
        }));
    }


    function changeRoundStatus(uint256 _pid, bool _value) public onlyOwner {
        presalePool[_pid].open = _value;
        emit RoundStatusChanged(_pid, _value);
    }

    function closeAllPools() external onlyOwner {
        for (uint256 i = 0; i < presalePool.length; i++) {
            changeRoundStatus(i, false);
        }
    }


    // send _time as 0 to set time to timestamp of the block
    /// @dev _time is unix timestamp
    function setIDOTime(uint256 _time) public onlyOwner {
        if (_time == 0) {
            idoTime = block.timestamp;
        } else {
            idoTime = _time;
        }
    }

    function getVestingCycle(uint256 _pid) internal view returns (uint256 _cycle) {
        require(idoTime != 0, "IDO has not yet happened");
        PresalePool storage pool = presalePool[_pid];
        require(idoTime + pool.lockTime <= block.timestamp, "Not unlocked yet");
        _cycle = 1 + block.timestamp - (idoTime + pool.lockTime) / oneMonth;
        if (_cycle > 10) {
            _cycle = 10;
        }
    }

    function getClaimableAmount(address _address, uint256 _pid) public view returns (uint256 _amount, uint256 _claimableCycles) {
        PresaleWallet storage user = presaleWallet[_pid][_address];
        require(user.inPresale, "User has not participated in this round");
        _claimableCycles = getVestingCycle(_pid) - user.numOfCollectTX;
        if (_claimableCycles == 0) {
            _amount = 0;
        } else {
            _amount = user.collectAmount * _claimableCycles;
        }
    }
    
    /// @dev function to claim tokens after TGE has happened
    function claimTokens(uint256 _pid) external {
        require(idoTime != 0, "IDO has not yet happened");
        PresaleWallet storage user = presaleWallet[_pid][_msgSender()];
        require(user.inPresale, "User has not participated in this round");
        (uint256 _amount, uint256 _claimableCycles) = getClaimableAmount(_msgSender(), _pid);
        user.numOfCollectTX += _claimableCycles;
        rogonToken().safeTransfer(_msgSender(), _amount);
        emit ClaimSuccessful(_amount, _claimableCycles);
    }

    function withdrawBUSDandUSDT(address to) public onlyOwner {
        busd().safeTransfer(to, busd().balanceOf(address(this)));
        usdt().safeTransfer(to, usdt().balanceOf(address(this)));
    }

    /// @notice Reverts if funds are sent directly to the smart contract
    receive() external payable {
        revert("Error: This Smart Contract cannot receive BNB");
    }

    fallback() external payable {
        revert("Error: This Smart Contract cannot receive money like this");
    }
}